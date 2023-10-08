import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/modules/sign_up/bloc/sign_up_state.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc() : super(SignUpState());
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
