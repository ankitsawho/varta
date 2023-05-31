import 'package:basics/features/auth/controller/auth_controller.dart';
import 'package:basics/features/landing/screens/landing_screen.dart';
import 'package:basics/router.dart';
import 'package:basics/screens/home_screen.dart';
import 'package:basics/screens/loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Basics",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true
      ),
      onGenerateRoute: (setting) => generateRoute(setting),
      home: ref.watch(userDataProvider).when(data: (user){
        if(user == null){
          return const LandingScreen();
        }
        return const Home();
      }, error: (err, trace){
        return Scaffold(body: Center(child: Text(err.toString()),),);
      }, loading: () => const Loader()),
    );
  }
}

