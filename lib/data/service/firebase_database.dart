import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:injectable/injectable.dart';
import 'package:note_app/data/models/note/note_model.dart';

@lazySingleton
class FirebaseDatabaseService {
  FirebaseDatabaseService() {
    database = FirebaseDatabase.instance;
    ref = database.ref();
  }

  late FirebaseDatabase database;

  late DatabaseReference ref;

  User? _currentUser;

  User? get currentUser => _currentUser;

  DatabaseReference get noteRef => ref.child('notes/${_currentUser?.uid}');

  Future<void> createUserRef(User user) async {
    final data = {
      'email': user.email,
    };
    await ref.child('users/${user.uid}').set(data);
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }

  void clearCurrentUser() {
    _currentUser = null;
  }

  Future<NoteModel> createNewNote() async {
    final noteRef = ref.child('notes/${_currentUser?.uid}');
    final newNoteRef = noteRef.push();
    final now = DateTime.now();
    final data = {
      'createdAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
    };
    await newNoteRef.set(data);
    return NoteModel(
      key: newNoteRef.key,
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
  }

  Future<void> updateNote({
    required NoteModel note,
    required String content,
    required String title,
  }) async {
    final noteRef = ref.child('notes/${_currentUser?.uid}/${note.key}');
    final now = DateTime.now();
    noteRef.update({
      'title': title,
      'content': content,
      'updatedAt': now.toIso8601String(),
    });
  }

  Future<List<NoteModel>> getNotes() async {
    final noteRef = ref.child('notes/${_currentUser?.uid}');
    List<NoteModel> results = [];
    final value = await noteRef.get();
    for (var note in value.children) {
      final data = note.value as Map?;
      final content = data?['content'] as String?;

      ///Remove notes that have empty content - this only works
      ///when creating new note
      if (content == null || content.isEmpty == true) {
        await _removeNote(note.key ?? '');
      } else {
        ///Remove empty note - when editing
        final doc = Document.fromJson(jsonDecode(content));
        if (doc.toPlainText().trim().isEmpty) {
          await _removeNote(note.key ?? '');
        } else {
          ///Create note model to add to list
          final noteModel = NoteModel(
            key: note.key,
            content: data?['content'],
            title: data?['title'],
            createdAt: data?['createdAt'],
            updatedAt: data?['updatedAt'],
          );
          results.add(noteModel);
        }
      }
    }
    return results.reversed.toList();
  }

  Future<void> _removeNote(String key) async {
    final currentRef = ref.child('notes/${_currentUser?.uid}/$key');
    await currentRef.remove();
  }
}
