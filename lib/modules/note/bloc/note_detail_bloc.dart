import 'dart:async';
import 'dart:convert';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/data/models/note/note_model.dart';
import 'package:note_app/data/service/firebase_database.dart';
import 'package:note_app/modules/note/bloc/note_detail_state.dart';
import 'package:note_app/utils/date_time_utils.dart';
import 'package:note_app/utils/string_utils.dart';

class NoteDetailBloc extends Cubit<NoteDetailState> {
  NoteDetailBloc({required this.note})
      : super(NoteDetailState(
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
          showingDateType: NoteDateType.createdAt,
        )) {
    _initNoteContent();
    _setOnNoteChange();
  }

  final NoteModel note;
  FirebaseDatabaseService dbService = getIt<FirebaseDatabaseService>();

  late StreamSubscription noteChangeStream;

  QuillController controller = QuillController.basic();

  String get _noteContent => jsonEncode(controller.document.toDelta().toJson());

  String getDateText() {
    if (state.showingDateType == NoteDateType.createdAt) {
      final createDate = DateTime.tryParse(state.createdAt ?? '');
      if (createDate != null) {
        return 'Created at: ${DateTimeUtils().formatDate(createDate)}';
      } else {
        return '';
      }
    } else {
      final updateDate = DateTime.tryParse(state.updatedAt ?? '');
      if (updateDate != null) {
        return 'Updated at: ${DateTimeUtils().formatDate(updateDate)}';
      } else {
        return '';
      }
    }
  }

  void updateNoteDateType() {
    emit(state.updateDateType());
  }

  @override
  Future<void> close() {
    noteChangeStream.cancel();
    controller.dispose();
    return super.close();
  }

  void _initNoteContent() {
    if (note.content != null && note.content?.isNotEmpty == true) {
      final contentJson = jsonDecode(note.content ?? '');
      final document = Document.fromJson(contentJson);
      controller.dispose();
      controller = QuillController(
        document: document,
        selection: TextSelection.collapsed(
          offset: document.toPlainText().length - 1,
        ),
      );
    }
  }

  void _setOnNoteChange() {
    noteChangeStream = controller.changes.listen(
      (_) {
        EasyDebounce.debounce(
          'note-content',
          const Duration(milliseconds: 500),
          () {
            final plainContent = controller.document.toPlainText();
            final title = StringUtils.getNoteTitleFromContent(plainContent);
            dbService.updateNote(
              note: note,
              content: _noteContent,
              title: title,
            );
            emit(state.changeUpdatedAt());
          },
        );
      },
    );
  }
}
