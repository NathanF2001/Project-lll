import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Pessoa.dart';

class PessoaController{

  final _user = FirebaseFirestore.instance;

  Future<List<dynamic>> addUser(email,nome,foto,id) async {
    /**
     * Método que adiciona usuário no Firestore
     */
    final pessoa = Pessoa(email, nome, "", "", foto,[]);

    await _user.collection("Users").doc(id).set(pessoa.ToJson());
    DocumentReference ref = _user.collection("Users").doc(id);


    return [pessoa,ref];
  }

  Future<void> updateUser(Pessoa pessoa,id){
    _user.collection("Users").doc(id).update(pessoa.ToJson());
  }

  getInfo_user(fuser)async{
    /**
     * Método que retorna informações do usuário de acordo com Authetication
     */
    return await _user.collection("Users").doc(fuser.uid).get().then((DocumentSnapshot documentsnapshot) async{


      if (!documentsnapshot.exists){
        // Caso que a conta está sendo criada
        return addUser(fuser.email, fuser.displayName, fuser.photoURL, fuser.uid);
      }
      else{
        final pessoa = Pessoa.fromJson(documentsnapshot.data());
        return [pessoa,documentsnapshot.reference];
      }
    });
  }

  Future<Pessoa> get_user(DocumentReference ref) async {
    return await ref.get().then((value) => Pessoa.fromJson(value.data()));
  }

  getref (String email) async{

    return await _user.collection("Users").where("email",isEqualTo: email).get().then((value) => value.docs.first.reference);

  }

  update_Turmas(cod_turma,id_pessoa,Pessoa pessoa){
    /**
     * Método que atualiza quantidade de turmas do usuário
     */
    pessoa.add_turma(cod_turma);
    id_pessoa.update({
      "Turmas_reference": FieldValue.arrayUnion([cod_turma])
    });
    return pessoa;
  }
}