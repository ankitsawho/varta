import 'package:flutter/material.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  const MyMessageCard({Key? key, required this.message, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width-45,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          color: Colors.cyan,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(padding: const EdgeInsets.only(left: 12, right: 32, top: 5, bottom: 20), child: Text(message, style: const TextStyle(fontSize: 16, color: Colors.white),),),
              Positioned(bottom: 4, right: 10, child: Row(
                children: [
                  Text(date, style: const TextStyle(color: Colors.white70, fontSize: 10),),
                  const SizedBox(width: 5,),
                  const Icon(Icons.done_all, color: Colors.white60, size: 18,)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
