import 'package:flutter_bloc/flutter_bloc.dart';
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

  onEmailChanged(String email) {}
}
