import 'package:note_app/data/models/note/note_model.dart';

class HomeState {
  const HomeState({
    this.notes = const [],
  });

  final List<NoteModel> notes;
}
