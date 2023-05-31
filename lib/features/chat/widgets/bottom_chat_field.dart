import 'package:basics/features/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;
  const BottomChatField({Key? key, required this.receiverUserId}) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool showSendButton = false;
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void sendTextMessage() async {
    ref.read(chatControllerProvider).sendTextMessage(context, _messageController.text.trim(), widget.receiverUserId);
    setState(() {
      _messageController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.cyan.shade50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.emoji_emotions_outlined)),
              Expanded(child: TextField(onChanged: (val){
                setState(() {
                  if(val.trim().isNotEmpty){
                    setState(() {
                      showSendButton = true;
                    });
                  }else{
                    showSendButton = false;
                  }
                });
              },controller: _messageController
                ,keyboardType: TextInputType.multiline, maxLines: 5, minLines: 1 ,decoration: InputDecoration(hintText: "Message", border: InputBorder.none),)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.attach_file_rounded)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined)),
            ],
          ),
        )),
        if(showSendButton)
          InkWell(
            onTap: sendTextMessage,
            child: Container(
            width: 54,
            height: 54,
            margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: Colors.cyan),
            child: const Icon(Icons.send_rounded, color: Colors.white,),
        ),
          )
      ],
    );
  }
}
