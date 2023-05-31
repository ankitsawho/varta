import 'dart:io';

import 'package:basics/features/auth/screens/otp_screen.dart';
import 'package:basics/features/auth/screens/user_info_screen.dart';
import 'package:basics/features/common/repository/common_firebase_storage_repository.dart';
import 'package:basics/models/user_model.dart';
import 'package:basics/screens/home_screen.dart';
import 'package:basics/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore
  });

  Future<UserModel?> getCurrentUserData() async {
    UserModel? user;
    var userData = await firestore.collection("users").doc(auth.currentUser?.uid).get();
    if(userData.data() != null){
      user = UserModel.fromJson(userData.data()!);
    }
    return user;
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    debugPrint("VerifyComplete");
    await auth.signInWithCredential(credential);
  }

  void verificationFailed(e){
    debugPrint("Verify Failed");
    throw Exception(e.message);
  }

  void codeAutoRetrievalTimeout(String verificationId){
    debugPrint("Time Out");
  }

  void navigateToOTPScreen(BuildContext context, String verificationId){
    Navigator.pushNamed(context, OTPScreen.routeName, arguments: verificationId);
  }

  void signInWithPhone(BuildContext context,String phoneNumber) async {
    debugPrint("SignInWithPhone");
    try{
      await auth.verifyPhoneNumber(phoneNumber: phoneNumber,verificationCompleted: verificationCompleted, verificationFailed: verificationFailed,
          codeSent: ((String verficationId, int? resendToken) async {
            debugPrint("Code Sent");
            navigateToOTPScreen(context, verficationId);
          }), codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } on FirebaseAuthException catch(e){
      showSnackbar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP
}) async {
      try{
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOTP);
        await auth.signInWithCredential(credential);
        Navigator.pushNamedAndRemoveUntil(context, UserInfoScreen.routeName, (route) => false);
      } on FirebaseAuthException catch (e){
        showSnackbar(context: context, content: e.message!);
      }
  }

  void saveUserData({
    required String name,
    required File? profilePicture,
    required ProviderRef ref,
    required BuildContext context
}) async {
    try{
      String uid = auth.currentUser!.uid;
      String photoUrl = "";
      if(profilePicture != null){
        photoUrl = await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToFirebase('profilePictures/$uid', profilePicture);
      }
      var user = UserModel(name: name, uid: uid, profilePicture: photoUrl, isOnline: true, phoneNumber: auth.currentUser!.phoneNumber!, groupIds: []);
      await firestore.collection("users").doc(uid).set(user.toJson());
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false);
    }catch(e){
      showSnackbar(context: context, content: e.toString());
    }
  }

  Stream<UserModel> userData(String userID){
    return firestore.collection('users').doc(userID).snapshots().map((event){
      return UserModel.fromJson(event.data() as Map<String, dynamic>);
    });
  }
}