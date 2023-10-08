import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_database/firebase_database.dart';

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
    ref.child('users/${user.uid}').set(data).then((value) {
      setCurrentUser(user);
    });
  }

  void setCurrentUser(User user) {
    _currentUser = user;
  }
}
