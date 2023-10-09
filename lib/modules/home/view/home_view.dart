import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/modules/home/bloc/home_bloc.dart';
import 'package:note_app/modules/home/bloc/home_state.dart';
import 'package:note_app/modules/home/widgets/note_item.dart';
import 'package:note_app/routes/app_router.dart';
import 'package:note_app/utils/dialog_utils.dart';

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
        IconButton(
          onPressed: () {
            DialogUtils().showConfirmation(
              context: context,
              message: 'Do you want to log out?',
              onConfirm: () {
                _bloc.logOut();
              },
            );
          },
          icon: const Icon(
            Icons.logout_outlined,
            size: 28.0,
          ),
        ),
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.notes.isEmpty) {
              return _EmptyListNote(
                onRefresh: () => _bloc.getNotes(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                _bloc.getNotes();
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = state.notes[index];
                  return NoteItem(
                    item: item,
                    onTap: () async {
                      await getIt<AppRouter>()
                          .push(NoteDetailPageRoute(note: item));
                      _bloc.getNotes();
                    },
                  );
                },
                itemCount: state.notes.length,
              ),
            );
          },
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

class _EmptyListNote extends StatelessWidget {
  final VoidCallback onRefresh;

  const _EmptyListNote({
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefresh.call();
      },
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: const Center(
              child: Text(
                'You have no notes!',
                style: TextStyle(
                  fontSize: 28.0,
                  color: CupertinoColors.inactiveGray,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
