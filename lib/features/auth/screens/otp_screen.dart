import 'package:basics/features/auth/controller/auth_controller.dart';
import 'package:basics/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = "/otp-screen";
  final String verificationId;
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  void verifyOTP(WidgetRef ref ,BuildContext context, String userOTP){
    ref.read(authcControllerProvider).verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Verify your number", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        SizedBox(height: 48, width: MediaQuery.of(context).size.width,),
        const Text("We have sent SMS with a code."),
        const SizedBox(height: 20,),
        SizedBox(width: MediaQuery.of(context).size.width*0.5,
          child: TextField(
            style: TextStyle(
                fontSize: 22, letterSpacing: 16
            ),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
          hintText: "------",
          hintStyle: TextStyle(fontSize: 32, letterSpacing: 16)
        ),
          onChanged: (val){
              if(val.length == 6){
                showSnackbar(context: context, content: "Verifying OTP");
                verifyOTP(ref, context, val.trim());
              }
          },),)

      ],
    ),
    );
  }
}
