import 'package:brew_crew/models/firbase_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //function to get UserId
  FirebaseUser _getUserId(User user) {

    return user != null ? FirebaseUser(userId:user.uid) : null as FirebaseUser;
  }

  Stream <FirebaseUser> get user{

    return _auth.authStateChanges().map((User?user) => _getUserId(user!));
  }

  //method to sign in anon
  Future signInAnon() async {
    try{

      UserCredential result = await _auth.signInAnonymously();
      User user = result.user as User;
      return _getUserId(user);

    }

    catch(e){
      print(e.toString());
      return null;
    }
  }

  //method to sign in email
  Future signInWithEmailAndPassword (email, password) async{

    try{

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user as User;
      return _getUserId(user);
    }catch(e){

      print(e.toString());
      return null;
    }
  }

  //method to register with email
  Future registerWithEmailAndPassword(email, password) async{

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user as User;
      DatabaseService(user.uid).updateUserData('new crew member', '0', 100);
      return _getUserId(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async{

    try{
      return await _auth.signOut();

    }
    catch(e){
      print(e.toString());
    }
  }
}