import 'package:basics/features/auth/controller/auth_controller.dart';
import 'package:basics/features/auth/repository/auth_repository.dart';
import 'package:basics/utils/show_snackbar.dart';
import 'package:basics/widget/CustomButton.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  void pickCountry(){
    showCountryPicker(context: context ,showPhoneCode: true ,onSelect: (Country _country){
      setState(() {
        country = _country;
      });
    },
      countryListTheme: CountryListThemeData(
        flagSize: 24,
        textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        bottomSheetHeight: 500,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60),
            borderSide: const BorderSide(
              color: Colors.cyan
            ),
          ),
        ),
      ),);
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void sendPhoneNumber(){
    showSnackbar(context: context, content: "Please Wait");
    String phoneNumber = "+${country!.phoneCode}${phoneController.text.trim()}";
    ref.read(authcControllerProvider).signInWithPhone(context, phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Enter your phone number", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          SizedBox(height: 48, width: MediaQuery.of(context).size.width,),
          const Text("Varta needs to verify your phone number"),
          const SizedBox(height: 20,),
          TextButton(onPressed: pickCountry, child: const Text("Pick country")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(country != null) Text("+${country!.phoneCode}", style: const TextStyle(fontSize: 16, color: Colors.black87),),
              const SizedBox(width: 15,),
              SizedBox(child: TextField(controller: phoneController, decoration: const InputDecoration(
                hintText: "Phone number",
              ),
              keyboardType: TextInputType.number,),
                width: MediaQuery.of(context).size.width*0.6,
              )
            ],
          ),
          const Spacer(),
          if(country!=null && phoneController.text.trim().isNotEmpty)
            Container(child: CustomButton(text: "NEXT", callback: (){
              sendPhoneNumber();
          }), width: 120,),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
