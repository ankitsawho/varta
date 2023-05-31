import 'package:basics/features/auth/controller/auth_controller.dart';
import 'package:basics/utils/pick_image.dart';
import 'package:basics/widget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static const String routeName = "/user-info-screen";
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final TextEditingController nameTextEditingController = TextEditingController();
  File? image;

  @override
  void dispose() {
    nameTextEditingController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameTextEditingController.text.trim();
    if(name.isNotEmpty){
      ref.read(authcControllerProvider).saveUserData(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
                Spacer(),
                Stack(
                alignment: Alignment.center,
                children: [
                  image == null ? CircleAvatar(radius: size.width*0.25,) : CircleAvatar(radius: size.width*0.25, backgroundImage: FileImage(image!),),
                  IconButton(onPressed: (){
                    selectImage();
                  }, icon: const Icon(Icons.add_a_photo_outlined, size: 48, color: Colors.black45,), highlightColor: Colors.cyan,)
                ],
              ),
              SizedBox(height: 48,),
              SizedBox(width: size.width*0.8, child: TextField(
                controller: nameTextEditingController,
                decoration: InputDecoration(
                  hintText: "Enter your name"
                ),
              ),),
              SizedBox(height: 48,),
              CustomButton(text: "DONE", callback: (){
                storeUserData();
              }),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
