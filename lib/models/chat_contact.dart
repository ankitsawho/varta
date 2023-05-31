class ChatContact{
  final String name;
  final String profilePicture;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  ChatContact({
    required this.name,
    required this.profilePicture,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage
  });

  factory ChatContact.fromJson(Map<String, dynamic> json) {
    return ChatContact(
      name: json["name"] ?? '',
      profilePicture: json["profilePicture"] ?? '',
      contactId: json["contactId"] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(json["timeSent"]),
      lastMessage: json["lastMessage"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilePicture": profilePicture,
      "contactId": contactId,
      "timeSent": timeSent.millisecondsSinceEpoch,
      "lastMessage": lastMessage,
    };
  }
}