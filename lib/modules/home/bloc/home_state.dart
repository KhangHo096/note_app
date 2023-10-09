import 'package:equatable/equatable.dart';
import 'package:note_app/data/models/note/note_model.dart';

class HomeState extends Equatable {
  const HomeState({
    this.notes = const [],
  });

  final List<NoteModel> notes;

  HomeState copyWith({
    List<NoteModel>? notes,
  }) {
    return HomeState(
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [notes];
}
