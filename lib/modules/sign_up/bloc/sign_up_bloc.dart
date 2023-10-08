import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/modules/sign_up/bloc/sign_up_state.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpState());
  final form = FormGroup({
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
    'repeatPassword': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  }, validators: [
    const MustMatchValidator('password', 'repeatPassword', false),
  ]);

  String get email => form.control('email').value;

  String get password => form.control('password').value;


  ///Create a new user with email and password
  ///Returns the result of the request
  ///$1: success/failure
  ///$2: message/error message
  Future<(bool, String)> onSignUp() async {
    try {
      final credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user != null) {
        return (true, 'User created successfully');
      }
    } on FirebaseAuthException catch (error) {
      return (false, error.message ?? 'Unknown error');
    }
    return (false, 'Unknown error');
  }
}
