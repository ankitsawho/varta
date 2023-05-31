import 'dart:io';

import 'package:basics/features/auth/repository/auth_repository.dart';
import 'package:basics/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authcControllerProvider = Provider((ref){
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataProvider = FutureProvider((ref) {
  final authController = ref.watch(authcControllerProvider);
  return authController.getUserData();
});

class AuthController{
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref
});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    debugPrint("HELLO");
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber){
    debugPrint("Sign in With phone in auth controller");
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, userOTP){
    authRepository.verifyOTP(context: context, verificationId: verificationId, userOTP: userOTP);
  }

  void saveUserData(BuildContext context, String name, File? profilePicture){
    authRepository.saveUserData(name: name, profilePicture: profilePicture, ref: ref, context: context);
  }

  Stream<UserModel> userDataById(String userId){
    return authRepository.userData(userId);
  }
}