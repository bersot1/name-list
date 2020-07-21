import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nome_na_lista/IUser.dart';

class LoginController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser firebaseUser =
        (await _auth.signInWithCredential(credential)).user;
    var token = await firebaseUser.getIdToken();

    user.name = firebaseUser.displayName;
    user.email = firebaseUser.email;
    user.picture = firebaseUser.photoUrl;
    user.token = token.token;
    user.uid = firebaseUser.uid;

    return user;
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    user = new IUser();
  }
}
