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


      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      final fuser = result.user;

      Pessoa pessoa = await getInfo_user(fuser);

      return Nav.pushname(context, "/home",arguments: [pessoa,fuser.uid]);
    }
    catch (error){
      print("Error que deu: ${error}");
      return false;
    }
  }

  signWithEmailAndPassword(context,String email,String password)async{
    try{

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      final fuser = result.user;
      print(fuser.email);
      print(fuser.photoURL);
      print(fuser.uid);

      Pessoa pessoa = await getInfo_user(fuser);

      return Nav.pushname(context, "/home",arguments: [pessoa,fuser.uid]);
    }catch(error){
      print("Error que deu: ${error}");
      return false;
    }
  }

  cadastrar(context,String nome,String email,String senha)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: senha);

      final fuser = result.user;

      add_firebase(email, nome, "", fuser.uid);


      return true;

    }catch(error){
      print("Error que deu: ${error}");
      return false;
    }
  }

  add_firebase(email,nome,foto,id) async {
    final pessoa = Pessoa(email, nome, "", "", foto,[]);

    await _user.collection("Users").doc(id).set(pessoa.ToJson());

    return pessoa;
  }

  getInfo_user(fuser)async{
    return await _user.collection("Users").doc(fuser.uid).get().then((DocumentSnapshot documentsnapshot) async{


      if (!documentsnapshot.exists){
        return add_firebase(fuser.email, fuser.displayName, fuser.photoURL, fuser.uid);
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


  update_Turmas(id_turma,id_pessoa,Pessoa pessoa){
    pessoa.add_turma(id_turma);
    _user.collection("Users").doc(id_pessoa).update({
      "Turmas_reference": pessoa.Turmas_reference
    });
    return pessoa;
  }

  Future<void> logout() async{
    await _auth.signOut();
    await _googleSignin.signOut();
  }
}