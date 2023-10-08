import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmailField extends StatefulWidget {
  final String title;
  final String formControlName;

  const EmailField({
    super.key,
    required this.title,
    required this.formControlName,
  });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10.0),
          ReactiveTextField(
            formControlName: widget.formControlName,
            validationMessages: {
              'required': (error) => 'Email must not be empty',
              'email': (error) => 'Invalid email format'
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: _border(),
              enabledBorder: _border(),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}

class PasswordInputField extends StatefulWidget {
  final String title;
  final String formControlName;

  const PasswordInputField({
    super.key,
    required this.title,
    required this.formControlName,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10.0),
          ReactiveTextField(
            obscureText: _obscured,
            formControlName: widget.formControlName,
            validationMessages: {
              'required': (error) => 'Password is required',
              'minLength': (error) =>
                  'Password must have at least 8 characters',
              'maxLength': (error) =>
                  'Password cannot have more than 16 characters'
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: _border(),
              enabledBorder: _border(),
              suffixIconConstraints: const BoxConstraints(
                maxWidth: 45.0,
              ),
              suffixIcon: _visibilityButton(),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  TextButton _visibilityButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _obscured = !_obscured;
        });
      },
      child: Icon(
        _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: CupertinoColors.inactiveGray,
      ),
    );
  }
}
