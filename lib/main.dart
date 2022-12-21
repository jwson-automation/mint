import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mint/models/user.dart' as model;
import 'package:mint/screens/login_screen.dart';
import 'package:mint/screens/mintPage.dart';
import 'package:mint/utils/colors.dart';
import 'package:provider/provider.dart';

import 'provider/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDfvp25XiynQ89LqvIMKLNwHZ8MnqKns74",
          authDomain: "mint-3c22f.firebaseapp.com",
          projectId: "mint-3c22f",
          storageBucket: "mint-3c22f.appspot.com",
          messagingSenderId: "435460327625",
          appId: "1:435460327625:web:6ea3fda7ae6aaf2bb92518",
          measurementId: "G-CZDF3ZW9PX"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final model.User? user = Provider.of<UserProvider>(context).getUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: '민초반민초',
        // home: const ResponsiveLayout(
        //   mobilescreenLayout: MobileScreenLayout(),
        //   webScreenLayout: WebScreenLayout(),
        // )
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // if (user!.uid != null) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const MintPage();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: mintColor,
                  ),
                );
              }
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
