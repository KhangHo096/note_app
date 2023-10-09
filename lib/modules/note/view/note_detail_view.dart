import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:note_app/data/models/note/note_model.dart';
import 'package:note_app/modules/note/bloc/note_detail_bloc.dart';

@RoutePage()
class NoteDetailPage extends StatefulWidget {
  final NoteModel note;

  const NoteDetailPage({
    super.key,
    required this.note,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late final NoteDetailBloc _bloc;

  @override
  void initState() {
    _bloc = NoteDetailBloc(note: widget.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const _NoteTitle(),
              quill.QuillToolbar.basic(
                controller: _bloc.controller,
                showFontFamily: false,
                showCodeBlock: false,
                showInlineCode: false,
                showLink: false,
                showSearchButton: false,
                showSubscript: false,
                showSuperscript: false,
                showQuote: false,
                showIndent: false,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: quill.QuillEditor.basic(
                    controller: _bloc.controller,
                    readOnly: false,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _NoteTitle extends StatelessWidget {
  const _NoteTitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          BackButton(),
          Text(
            'Note',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
