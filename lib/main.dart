import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/data/service/firebase_database.dart';
import 'package:note_app/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    final firebaseDBService = getIt.get<FirebaseDatabaseService>();
    if (user == null) {
      firebaseDBService.clearCurrentUser();
    }
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = getIt<AppRouter>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      title: 'Note App',
      debugShowCheckedModeBanner: false,
    );
  }
}
