import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/modules/home/bloc/home_bloc.dart';
import 'package:note_app/modules/home/widgets/note_item.dart';
import 'package:note_app/routes/app_router.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    _bloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _homeTitle(),
              _notesList(),
              const Spacer(),
              _addButton(),
            ],
          ),
        ),
      ),
    );
  }

  Row _addButton() {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: () {
            _bloc.createNewNote();

          },
          icon: const Icon(
            Icons.add_box_outlined,
            size: 28.0,
          ),
        ),
      ],
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
