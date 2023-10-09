import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/data/service/firebase_database.dart';
import 'package:note_app/modules/home/bloc/home_state.dart';
import 'package:note_app/routes/app_router.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState()) {
    final user = dbService.currentUser;
    if (user != null) {
      currentUser = user;
    }
    getNotes();
  }

  late User currentUser;

  FirebaseDatabaseService dbService = getIt<FirebaseDatabaseService>();

  Future<void> createNewNote() async {
    final newNote = await dbService.createNewNote();
    await getIt<AppRouter>().push(NoteDetailPageRoute(
      note: newNote,
    ));
    getNotes();
  }

  void getNotes() async {
    final notes = await dbService.getNotes();
    emit(state.copyWith(notes: notes));
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    getIt<AppRouter>().replace(const SignInPageRoute());
  }
}
