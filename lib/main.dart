import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mediaapp/auth/auth.dart';
import 'package:mediaapp/auth/login_or_register.dart';
import 'package:mediaapp/firebase_options.dart';
import 'package:mediaapp/page/home_page.dart';
import 'package:mediaapp/page/profile_page.dart';
import 'package:mediaapp/page/user_page.dart';
import 'package:mediaapp/theme/dark_mode.dart';
import 'package:mediaapp/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Media App',
      theme: lightMode,
      darkTheme: darkMode,
      home: const AuthPage(),
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => const HomePage(),
        '/profile_page': (context) => const ProfilePage(),
        '/user_page': (context) => const UserPage(),
      },
    );
  }
}
