import 'package:basics/screens/call_list.dart';
import 'package:basics/features/chat/widgets/chat_list.dart';
import 'package:basics/screens/stories_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("varta", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 8, fontSize: 28, color: Colors.blueGrey),),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: <Widget>[
        ChatList(),
        StoryList(),
        CallList()
      ][currentIdx],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: "Chats", selectedIcon: Icon(Icons.chat_bubble),),
          NavigationDestination(icon: Icon(Icons.amp_stories_outlined), label: "Stories", selectedIcon: Icon(Icons.amp_stories),),
          NavigationDestination(icon: Icon(Icons.call_outlined), label: "Calls", selectedIcon: Icon(Icons.call),)
        ],
        selectedIndex: currentIdx,
        onDestinationSelected: (int index){
          setState(() {
            currentIdx = index;
          });
        },
      ),
    );
  }
}
