import 'package:basics/features/auth/controller/auth_controller.dart';
import 'package:basics/features/chat/repository/chat_repository.dart';
import 'package:basics/models/chat_contact.dart';
import 'package:basics/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Debug chat

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController{
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref
  });

  Stream<List<ChatContact>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatStream(String receiverId) {
    return chatRepository.getChatStream(receiverId);
  }

  void sendTextMessage(BuildContext context, String text, String receiverUserId){
    debugPrint("Chat controller (Send Text) : ");
    userDataProvider;
    ref.read(userDataProvider).whenData((value){
      debugPrint("Value " + value!.name);
      chatRepository.sendTextMessage(context: context, text: text, receiverUserId: receiverUserId, senderUser: value!);
    });
  }
}