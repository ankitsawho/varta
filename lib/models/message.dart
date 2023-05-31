import 'package:basics/features/common/enum/MessageEnum.dart';

class Message{
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum messageType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.messageType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json["senderId"] ?? '',
      receiverId: json["receiverId"] ?? '',
      text: json["text"] ?? '',
      messageType: (json["messageType"] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(json["timeSent"]),
      messageId: json["messageId"] ?? '',
      isSeen: json["isSeen"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": this.senderId,
      "receiverId": this.receiverId,
      "text": this.text,
      "messageType": this.messageType.type,
      "timeSent": this.timeSent.millisecondsSinceEpoch,
      "messageId": this.messageId,
      "isSeen": this.isSeen,
    };
  }
}