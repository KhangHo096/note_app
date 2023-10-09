import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/data/service/firebase_database.dart';
import 'package:note_app/modules/sign_in/bloc/sign_in_state.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInBloc extends Cubit<SignInState> {
  SignInBloc() : super(SignInState());
  final form = FormGroup(
    {
      'email': FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
        ],
      ),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(16),
          Validators.minLength(8),
        ],
      ),
    },
  );

  String get email => form.control('email').value;

  String get password => form.control('password').value;
  final firebaseDBService = getIt.get<FirebaseDatabaseService>();

  ///Log in with email and password
  ///Returns the result of the request
  ///$1: success/failure
  ///$2: message/error message
  Future<(bool, String)> onSignIn() async {
    try {
      final credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credentials.user;
      if (user != null) {
        firebaseDBService.setCurrentUser(user);
        return (true, 'User created successfully');
      }
    } on FirebaseAuthException catch (_) {
      return (false, 'Invalid login credentials');
    }
    return (false, 'Unknown error');
  }
}
