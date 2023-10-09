import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app/modules/note/bloc/note_detail_bloc.dart';

@RoutePage()
class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late final NoteDetailBloc _bloc;

  @override
  void initState() {
    _bloc = NoteDetailBloc();
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
              QuillToolbar.basic(
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
                child: QuillEditor.basic(
                  controller: _bloc.controller,
                  readOnly: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
