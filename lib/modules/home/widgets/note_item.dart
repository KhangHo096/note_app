import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'lol',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
