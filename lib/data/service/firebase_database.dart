import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:note_app/data/models/note/note_model.dart';

@lazySingleton
class FirebaseDatabaseService {
  FirebaseDatabaseService() {
    database = FirebaseDatabase.instance;
    ref = FirebaseDatabase.instance.ref();
  }

  late FirebaseDatabase database;

  late DatabaseReference ref;

  User? _currentUser;

  User? get currentUser => _currentUser;

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
    );

  }

  Future<List<NoteModel>> getNotes() async {
    final noteRef = ref.child('notes/${_currentUser?.uid}');


    return [];
  }
}
