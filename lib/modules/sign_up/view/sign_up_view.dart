// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:note_app/modules/sign_up/bloc/sign_up_bloc.dart';
import 'package:note_app/widgets/input_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double _screenHeight = 0;
  late final SignUpBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SignUpBloc();
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
                const _SignUpTitle(),
                _body(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _body() {
    return Expanded(
      child: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: _bloc.form,
          child: Column(
            children: [
              SizedBox(height: _screenHeight * .1),
              const EmailField(
                title: 'Email',
                formControlName: 'email',
              ),
              SizedBox(height: _screenHeight * .05),
              const PasswordInputField(
                title: 'Password',
                formControlName: 'password',
              ),
              SizedBox(height: _screenHeight * .05),
              const PasswordInputField(
                title: 'Repeat password',
                formControlName: 'repeatPassword',
              ),
              SizedBox(height: _screenHeight * .03),
              const _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpTitle extends StatelessWidget {
  const _SignUpTitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          BackButton(),
          Text(
            'Sign up',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context);
    return Center(
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        color: (form?.valid ?? false)
            ? CupertinoColors.activeBlue
            : CupertinoColors.inactiveGray,
        onPressed: () async {
          final bloc = context.read<SignUpBloc>();
          final response = await bloc.onSignUp();
          if (response.$1) {
            showCupertinoDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text(
                    response.$2,
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            print('onSignUp ${response.$2}');
          }
        },
        child: const Text(
          'Sign up',
        ),
      ),
    );
  }
}
