import 'package:basics/features/auth/controller/auth_controller.dart';
import 'package:basics/features/chat/widgets/bottom_chat_field.dart';
import 'package:basics/features/chat/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = "/chat-screen";
  final String name;
  final String uid;
  const ChatScreen({Key? key, required this.name, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: 8,),
            Container(
              child: StreamBuilder<UserModel>(
                stream: ref.read(authcControllerProvider).userDataById(uid),
                builder: (context, snapshot){
                  debugPrint(snapshot.toString());
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                    return Column(
                      children: [Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(name, style: const TextStyle(overflow: TextOverflow.fade, fontSize: 18, fontWeight: FontWeight.bold),),
                      ), Text(snapshot.data!.isOnline ? "online" : "offline", style: const TextStyle(fontSize: 14, color: Colors.blueGrey),)],
                    );
                }
              )
            )
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.video_call_outlined)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: MessageList(receiverUserId: uid)),
          BottomChatField(receiverUserId: uid,)
        ],
      ),
    );
  }
}
