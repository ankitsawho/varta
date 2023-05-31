import 'package:basics/features/auth/screens/login_screen.dart';
import 'package:basics/widget/CustomButton.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context){
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const Text("Welcome to Varta", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
          const Spacer(),
          Image.asset('assets/images/varta_logo.png', width: size.width*0.6),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Read our Privacy Policy. Tap "Agree and continue" to accept the Terms and Service.', style: TextStyle(color: Colors.blueGrey), textAlign: TextAlign.center,),
          ),
          CustomButton(text: "AGREE AND CONTINUE", callback: () => navigateToLoginScreen(context)),
          const Spacer()
        ],
      )),
    );
  }
}
