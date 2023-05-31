import 'package:basics/features/chat/controller/chat_controller.dart';
import 'package:basics/models/message.dart';
import 'package:basics/screens/loader.dart';
import 'package:basics/widget/message_card.dart';
import 'package:basics/widget/my_message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


class MessageList extends ConsumerStatefulWidget {
  final String receiverUserId;
  const MessageList({Key? key, required this.receiverUserId}) : super(key: key);

  @override
  ConsumerState<MessageList> createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessageList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).chatStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            messageController.jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(itemCount: snapshot.data!.length,
            controller: messageController,
            itemBuilder: (context, index){
              final messageData = snapshot.data![index];
              if(messageData.senderId == FirebaseAuth.instance.currentUser!.uid){
                return MyMessageCard(message: messageData.text, date: DateFormat.Hm().format(messageData.timeSent));
              }
              return MessageCard(message: messageData.text, date: DateFormat.Hm().format(messageData.timeSent));
            },);
        }
    );
  }
}

