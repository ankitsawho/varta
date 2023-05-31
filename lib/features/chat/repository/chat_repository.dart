import 'package:basics/features/chat/widgets/message_list.dart';
import 'package:basics/features/common/enum/MessageEnum.dart';
import 'package:basics/models/chat_contact.dart';
import 'package:basics/models/message.dart';
import 'package:basics/models/user_model.dart';
import 'package:basics/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository{
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  Stream<List<Message>> getChatStream(String receiverUserId) {
    return firestore.collection("users").doc(auth.currentUser!.uid).collection("chats").doc(receiverUserId).collection("messages").orderBy('timeSent').snapshots().map((event){
      List<Message> messages = [];
      for (var document in event.docs){
        messages.add(Message.fromJson(document.data()));
      }
      return messages;
    });
  }

  Stream<List<ChatContact>> getChatContacts(){
    return firestore.collection("users").doc(auth.currentUser!.uid).collection("chats").snapshots().asyncMap((event) async {
      List<ChatContact> contacts = [];
      for(var document in event.docs){
        var chatContact = ChatContact.fromJson(document.data());
        var userData = await firestore.collection("users").doc(chatContact.contactId).get();
        var user = UserModel.fromJson(userData.data()!);
        contacts.add(ChatContact(name: user.name, profilePicture: user.profilePicture, contactId: chatContact.contactId, timeSent: chatContact.timeSent, lastMessage: chatContact.lastMessage));
      }
      return contacts;
    });
  }

  void _saveDataToContactsSubCollection(
      UserModel senderUserData,
      UserModel receiverUserData,
      String text,
      DateTime timeSent,
      String receiverUserId
      ) async {

    var receiverChatContact = ChatContact(name: senderUserData.name, profilePicture: senderUserData.profilePicture, contactId: senderUserData.uid, timeSent: timeSent, lastMessage: text);
    await firestore.collection("users").doc(receiverUserId).collection("chats").doc(auth.currentUser!.uid).set(receiverChatContact.toJson());

    var senderChatContact = ChatContact(name: receiverUserData.name, profilePicture: receiverUserData.profilePicture, contactId: receiverUserData.uid, timeSent: timeSent, lastMessage: text);
    await firestore.collection("users").doc(auth.currentUser!.uid).collection("chats").doc(receiverUserId).set(senderChatContact.toJson());
  }

  void _saveMessageToMessageSubCollection({
    required String receiverUserId, required String text, required DateTime timeSent, required String messageId, required String username, required String receiverUsername, required MessageEnum messageType
  }) async {
    final message = Message(senderId: auth.currentUser!.uid, receiverId: receiverUserId, text: text, messageType: messageType, timeSent: timeSent, messageId: messageId, isSeen: false);
    await firestore.collection("users").doc(auth.currentUser!.uid).collection("chats").doc(receiverUserId).collection("messages").doc(messageId).set(message.toJson());
    await firestore.collection("users").doc(receiverUserId).collection("chats").doc(auth.currentUser!.uid).collection("messages").doc(messageId).set(message.toJson());

  }

  void sendTextMessage({required BuildContext context, required String text, required String receiverUserId, required UserModel senderUser}) async {
    try{
      var timeSent = DateTime.now();
      UserModel receiverUserData;
      var userDataMap = await firestore.collection("users").doc(receiverUserId).get();
      receiverUserData = UserModel.fromJson(userDataMap.data()!);
      var messageId = const Uuid().v1();
      _saveDataToContactsSubCollection(senderUser, receiverUserData, text, timeSent, receiverUserId);
      _saveMessageToMessageSubCollection(receiverUserId: receiverUserId, text: text, timeSent: timeSent, messageId: messageId, username: senderUser.name, receiverUsername: receiverUserData.name, messageType: MessageEnum.TEXT);
    }catch(e){
      showSnackbar(context: context, content: e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
  }
}