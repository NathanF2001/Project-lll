import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/UserPage.dart';

class AuthController{
  final _googleSignin = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _user = FirebaseFirestore.instance;

  signWithGoogle(context) async{
    try{
      final GoogleSignInAccount googleUser = await _googleSignin.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      print("Google user: ${googleUser.email}");
      print("Google user: ${googleUser.id}");

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      final fuser = result.user;
      print("Firebase nome: ${fuser.displayName}");
      print("Firebase email: ${fuser.email}");
      print("Firebase url: ${fuser.photoURL}");
      print("Firebase uid: ${fuser.uid}");

      Pessoa pessoa = await getInfo_user(fuser);

      return Nav.pushname(context, "/home",arguments: [pessoa,fuser.uid]);
    }
    catch (error){
      print("Error que deu: ${error}");
      return false;
    }
  }

  getInfo_user(fuser)async{
    return await _user.collection("Users").doc(fuser.uid).get().then((DocumentSnapshot documentsnapshot) async{


      if (!documentsnapshot.exists){
        final pessoa = Pessoa(fuser.email, fuser.displayName, "", "", fuser.photoURL,[]);

        await _user.collection("Users").doc(fuser.uid).set(pessoa.ToJson());

        return pessoa;
      }
      else{
        final pessoa = Pessoa.fromJson(documentsnapshot.data());
        return pessoa;
      }


    });
  }

  Future<DocumentSnapshot> get_user(id){
    return _user.collection("Users").doc(id).get();
  }

  Future<void> logout() async{
    await _auth.signOut();
    await _googleSignin.signOut();
  }
}