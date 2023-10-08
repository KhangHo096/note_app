import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:note_app/modules/sign_in/bloc/sign_in_bloc.dart';
import 'package:note_app/modules/sign_in/bloc/sign_in_state.dart';
import 'package:note_app/widgets/input_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  double _screenHeight = 0;
  late final SignInBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SignInBloc();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        body: KeyboardDismisser(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return ReactiveForm(
                          formGroup: _bloc.form,
                          child: Column(
                            children: [
                              SizedBox(height: _screenHeight * .1),
                              EmailField(
                                title: 'Email',
                                formControlName: 'email',
                              ),
                              SizedBox(height: _screenHeight * .05),
                              PasswordInputField(
                                title: 'Password',
                                formControlName: 'password',
                              ),
                              SizedBox(height: _screenHeight * .03),
                              _SignInButton(),
                              Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Don\'t have an account?',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Sign in',
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return Center(
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: (form?.valid ?? false)
            ? CupertinoColors.activeBlue
            : CupertinoColors.inactiveGray,
        onPressed: () {},
        child: const Text(
          'Sign in',
        ),
      ),
    );
  }
}
