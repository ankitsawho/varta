import 'dart:convert';

class UserModel{
  final String name;
  final String uid;
  final String profilePicture;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupIds;

  UserModel({
      required this.name,
    required this.uid,
    required this.profilePicture,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupIds
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "uid": uid,
      "profilePicture": profilePicture,
      "isOnline": isOnline,
      "phoneNumber": phoneNumber,
      "groupIds": groupIds,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      uid: json["uid"],
      profilePicture: json["profilePicture"],
      isOnline: json["isOnline"],
      phoneNumber: json["phoneNumber"],
      groupIds: List<String>.from(json["groupIds"]),
    );
  }
//

  // TODO: Fix groupIds, It is stored as string firestore, might give error in future


//
}