import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class WazirXCloneFirebaseUser {
  WazirXCloneFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

WazirXCloneFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WazirXCloneFirebaseUser> wazirXCloneFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<WazirXCloneFirebaseUser>(
        (user) => currentUser = WazirXCloneFirebaseUser(user));
