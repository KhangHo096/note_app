import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/modules/home/widgets/note_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _homeTitle(),
            _notesList(),
          ],
        ),
      ),
    );
  }

  Expanded _notesList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return NoteItem();
          },
          itemCount: 4,
        ),
      ),
    );
  }

  Padding _homeTitle() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'Notes',
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
