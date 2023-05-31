import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final String date;
  const MessageCard({Key? key, required this.message, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width-45,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(padding: const EdgeInsets.only(left: 12, right: 32, top: 5, bottom: 20), child: Text(message, style: const TextStyle(fontSize: 16, color: Colors.black87),),),
              Positioned(bottom: 4, right: 10, child: Text(date, style: const TextStyle(color: Colors.black54, fontSize: 10),))
            ],
          ),
        ),
      ),
    );
  }
}
