import 'package:basics/features/auth/screens/login_screen.dart';
import 'package:basics/features/auth/screens/otp_screen.dart';
import 'package:basics/features/auth/screens/user_info_screen.dart';
import 'package:basics/features/contacts/screens/contacts_screen.dart';
import 'package:basics/features/chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch(settings.name){
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => OTPScreen(verificationId: verificationId,));
    case UserInfoScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserInfoScreen());
    case ContactScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ContactScreen());
    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(builder: (context) => ChatScreen(name: name, uid: uid,));
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold(body: Text("Error"),));
  }
}