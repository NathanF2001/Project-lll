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

  update_Turmas(id_turma,id_pessoa,Pessoa pessoa){
    /**
     * Método que atualiza quantidade de turmas do usuário
     */
    pessoa.add_turma(id_turma);
    id_pessoa.update({
      "Turmas_reference": FieldValue.arrayUnion([id_turma])
    });
    return pessoa;
  }
}