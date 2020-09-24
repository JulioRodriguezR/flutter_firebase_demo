import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  // Register firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Initial session on Google
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> sigIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return null;
    }
    final GoogleSignInAuthentication gSA =
        await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithCredential(
      GoogleAuthProvider.getCredential(
          idToken: gSA.idToken, accessToken: gSA.accessToken),
    );

    // Return obj FirebaseUser with google account data

    return user;
  }

  signOut() async {
    await _auth.signOut().then((onValue) => print("sign out"));
    _googleSignIn.signOut();
  }
}
