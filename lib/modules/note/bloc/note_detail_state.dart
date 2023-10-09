import 'package:equatable/equatable.dart';

class NoteDetailState extends Equatable {
  const NoteDetailState({
    required this.createdAt,
    required this.updatedAt,
    required this.showingDateType,
  });

  final String? createdAt;
  final String? updatedAt;
  final NoteDateType showingDateType;

  NoteDetailState updateDateType() {
    return NoteDetailState(
      createdAt: createdAt,
      updatedAt: updatedAt,
      showingDateType: showingDateType == NoteDateType.createdAt
          ? NoteDateType.updatedAt
          : NoteDateType.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        createdAt,
        updatedAt,
        showingDateType,
      ];
}

enum NoteDateType {
  createdAt,
  updatedAt,
}
