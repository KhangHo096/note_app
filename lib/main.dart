import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/modules/home/view/home_view.dart';
import 'package:note_app/modules/sign_in/view/sign_in_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      title: 'Note App',
      home: const SignInView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
