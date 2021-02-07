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
      print(fuser.email);
      print(fuser.displayName);

      List<dynamic> result_firebase = await getInfo_user(fuser);
      Pessoa pessoa = result_firebase[0]; // informações do usuario
      DocumentReference id = result_firebase[1]; // referencia do usuario

      return Nav.pushname(context, "/home",arguments: [pessoa,id]);
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

      List<dynamic> result_firebase = await getInfo_user(fuser);
      Pessoa pessoa = result_firebase[0]; // informações do usuario
      DocumentReference id = result_firebase[1]; // referencia do usuario

      return Nav.pushname(context, "/home",arguments: [pessoa,id]);
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
    DocumentReference ref = _user.collection("Users").doc(id);


    return [pessoa,ref];
  }

  getInfo_user(fuser)async{
    return await _user.collection("Users").doc(fuser.uid).get().then((DocumentSnapshot documentsnapshot) async{


      if (!documentsnapshot.exists){
        return add_firebase(fuser.email, fuser.displayName, fuser.photoURL, fuser.uid);
      }
      else{
        final pessoa = Pessoa.fromJson(documentsnapshot.data());
        return [pessoa,documentsnapshot.reference];
      }


    });
  }

  Future<DocumentSnapshot> get_user(ref) async {
    return await ref.get();
  }


  update_Turmas(id_turma,id_pessoa,Pessoa pessoa){
    pessoa.add_turma(id_turma);
    id_pessoa.update({
      "Turmas_reference": pessoa.Turmas_reference
    });
    return pessoa;
  }

  Future<void> logout() async{
    await _auth.signOut();
    await _googleSignin.signOut();
  }
}