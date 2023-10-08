import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/modules/sign_in/bloc/sign_in_bloc.dart';
import 'package:note_app/modules/sign_in/bloc/sign_in_state.dart';
import 'package:note_app/routes/app_router.dart';
import 'package:note_app/widgets/input_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                const _SignInTitle(),
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
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            return ReactiveForm(
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
                  SizedBox(height: _screenHeight * .03),
                  const _SignInButton(),
                  const _SignUpText(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SignInTitle extends StatelessWidget {
  const _SignInTitle();

  @override
  Widget build(BuildContext context) {
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
        onPressed: () async {
          final bloc = context.read<SignInBloc>();
          final response = await bloc.onSignIn();
          if (response.$1) {
            getIt<AppRouter>().push(const HomePageRoute());
          } else {
            print('onSignIn ${response.$2}');
          }
        },
        child: const Text(
          'Sign in',
        ),
      ),
    );
  }
}

class _SignUpText extends StatelessWidget {
  const _SignUpText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          getIt<AppRouter>().push(const SignUpPageRoute());
        },
        child: const Text(
          'Don\'t have an account?',
        ),
      ),
    );
  }
}
