import 'package:basics/features/chat/controller/chat_controller.dart';
import 'package:basics/features/contacts/screens/contacts_screen.dart';
import 'package:basics/features/chat/screens/chat_screen.dart';
import 'package:basics/models/chat_contact.dart';
import 'package:basics/screens/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChatList extends ConsumerWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder<List<ChatContact>>(
        stream: ref.watch(chatControllerProvider).chatContacts(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Loader();
          }
          return ListView.builder(itemBuilder: (context, index){
            var chatContactData = snapshot.data![index];
            return InkWell(
              onTap: (){
                debugPrint("Receiver ID (hopefully) " + chatContactData.contactId);
                Navigator.pushNamed(context, ChatScreen.routeName, arguments: {
                  'name': chatContactData.name,
                  'uid': chatContactData.contactId
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  leading: chatContactData.profilePicture.isNotEmpty ? CircleAvatar(backgroundImage: NetworkImage(chatContactData.profilePicture),) : CircleAvatar(
                    child: Text(chatContactData.name[0].toUpperCase()),),
                  title: Text(chatContactData.name),
                  subtitle: Text(chatContactData.lastMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 13),),
                  trailing: Text(DateFormat.Hm().format(chatContactData.timeSent), style: const TextStyle(fontSize: 10)),),
              ),
            );
          }, itemCount: snapshot.data!.length,);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, ContactScreen.routeName);
        },
        child: const Icon(Icons.message_outlined),
      ),
    );
  }
}
