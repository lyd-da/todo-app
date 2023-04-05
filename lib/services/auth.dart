import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/model/auth.dart';

class AuthService {
  Future<void> login()async {
    
  }
 static Future<void> signup(Auth account)async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: account.email,
    password: account.password
  );
    } catch (e) {
      
    }
  }
}
