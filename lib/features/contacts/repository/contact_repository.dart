import 'package:basics/models/user_model.dart';
import 'package:basics/features/chat/screens/chat_screen.dart';
import 'package:basics/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsRepositoryProvider = Provider((ref) => ContactRepository(firestore: FirebaseFirestore.instance));

class ContactRepository{
  final FirebaseFirestore firestore;

  ContactRepository({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try{
      if(await FlutterContacts.requestPermission()){
        contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      }
    }catch(e){
        debugPrint(e.toString());
    }
    return contacts;
  }

  void contactHasVarta(Contact selectedContact, BuildContext context) async {
    try{
      var userCollection = await firestore.collection("users").get();
      bool isFound = false;
      var userData;
      for(var document in userCollection.docs){
        userData = UserModel.fromJson(document.data());
        String number =selectedContact.phones[0].normalizedNumber;
        if(number == userData.phoneNumber){
          isFound = true;
          break;
        }
      }
      if(isFound){
        debugPrint("In Repo : "+userData.uid);
        Navigator.pushNamed(context, ChatScreen.routeName,
        arguments: {
          'name': userData.name,
          'uid': userData.uid
        });
      }else {
        showSnackbar(context: context, content: "This contact doesn't have varta.");
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }
}