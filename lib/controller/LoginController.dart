import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/SocialEconomico.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/UserPage.dart';

class AuthController{
  final _googleSignin = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  signWithGoogle(context) async{
    /**
     * Logar com Google
     */
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

      List<dynamic> result_firebase = await PessoaController().getInfo_user(fuser);
      Pessoa pessoa = result_firebase[0]; // informações do usuario
      DocumentReference id = result_firebase[1]; // referencia do usuario
      DocumentReference id_SE = result_firebase[2];

      Nav.push(context, UserPage(pessoa, id, id_SE),replace: true);
    }on FirebaseAuthException catch(error){
      switch (error.code){
        case "wrong-password":
          return "Senha incorreta";
          break;
        case "user-not-found":
          return "Email não cadastrado";
          break;
        case "email-already-in-use":
          return "Conta está logada";
          break;
        case "invalid-email":
          return "Insira um email válido";
          break;
        case "too-many-requests":

        default:
          return "Login falhou, tente novamente";
          break;
      }

    }
  }

  signWithEmailAndPassword(context,String email,String password)async{
    /**
     * Logar com Email e Password
     */
    try{

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      final fuser = result.user;

      List<dynamic> result_firebase = await PessoaController().getInfo_user(fuser);
      Pessoa pessoa = result_firebase[0]; // informações do usuario
      DocumentReference id = result_firebase[1]; // referencia do usuario
      DocumentReference ref_SE = result_firebase[2]; // referencia SocialEconomico resultados
      Nav.push(context, UserPage(pessoa, id,ref_SE),replace: true);

      return "Ok";
    }on FirebaseAuthException catch(error){
      switch (error.code){
        case "wrong-password":
          return "Senha incorreta";
          break;
        case "user-not-found":
          return "Email não cadastrado";
          break;
        case "email-already-in-use":
          return "Conta está logada";
          break;
        case "invalid-email":
          return "Insira um email válido";
          break;
        case "too-many-requests":

        default:
          return "Login falhou, tente novamente";
          break;
      }

    }
  }

  cadastrar(context,String nome,String email,String senha)async{
    /**
     * Método de cadastrar por email
     */
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: senha);

      final fuser = result.user;

      DocumentReference ref_SE = await PessoaController().add_SE();

      PessoaController().addUser(email, nome, "", fuser.uid,ref_SE);


      return "ok";

    }on FirebaseAuthException catch(error){
      switch (error.code){
        case "wrong-password":
          return "Senha incorreta";
          break;
        case "user-not-found":
          return "Email não cadastrado";
          break;
        case "email-already-in-use":
          return "Conta está logada";
          break;
        case "invalid-email":
          return "Insira um email válido";
          break;
        case "too-many-requests":

        default:
          return "Login falhou, tente novamente";
          break;
      }

    }
  }
  
  sendEmailForgotPass(email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(error){
      switch (error.code){
        case "user-not-found":
          return "Email não cadastrado";
          break;
        case "invalid-email":
          return "Insira um email válido";
          break;
        default:
          return "Algum erro aconteceu, tente novamente";
          break;
      }
    }
  }

  Future<void> logout() async{
    /**
     * Método deslogar da conta auth
     */
    await _auth.signOut();
    await _googleSignin.signOut();
  }
}