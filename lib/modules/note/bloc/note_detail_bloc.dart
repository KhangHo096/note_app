import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app/modules/note/bloc/note_detail_state.dart';

class NoteDetailBloc extends Cubit<NoteDetailState> {
  NoteDetailBloc() : super(NoteDetailState()) {
    _setOnNoteChange();
  }

  _setOnNoteChange() {
    noteChangeStream = controller.changes.listen((_) {
      EasyDebounce.debounce(
        'note-content',
        const Duration(milliseconds: 500),
        () {
          final noteContent = controller.document.toPlainText();
        },
      );
    });
  }

  @override
  Future<void> close() {
    noteChangeStream.cancel();
    return super.close();
  }

  late StreamSubscription noteChangeStream;

  QuillController controller = QuillController.basic();
}
