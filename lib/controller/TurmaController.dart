import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';

class TurmaController {
  final _user = FirebaseFirestore.instance;

  create_turma(json, Pessoa pessoa, id_professor) async {
    /**
        Método para criar turma
     **/
    json["UrlTurma"] = pessoa.UrlFoto;
    json["Professor"] = id_professor;
    json["Alunos"] = [];
    json["number_Aluno"] = 0;


    DocumentReference ref = await _user.collection("Turmas").add({});


    json["id"] = ref;
    json["codigo"] = Utils.generate_key(6);
    pessoa.add_turma(json["codigo"]);

    _user.collection("Turmas").doc(ref.id).set(json);

    id_professor.update({"Turmas_reference": pessoa.Turmas_reference});

    return pessoa;
  }

  Future<void> updateTurma(Turma turma,id){
    _user.collection("Turmas").doc(id).update(turma.ToJson());
  }
  
  Future<void> updateProfessor(Turma turma,id,new_reference){
    _user.collection("Turmas").doc(id).update({"Professor": new_reference});
  }

  Future<QueryDocumentSnapshot> get_turmabycode(code) async {
    /**
        Método de um aluno recuperar referencia da turma que ele colocou codigo
     **/
    QuerySnapshot doc =
    await _user.collection("Turmas").where("codigo", isEqualTo: code).get();

    if (doc.docs.isNotEmpty) {
      return doc.docs.first;
    }

    return null;
  }

  addAlunoTurma(DocumentReference id_turma, id_pessoa) async {
    /**
        Método para adicionar um aluno na turma
     **/
    await _updateNumberAlunos(id_turma);
    return await addAluno(id_turma, id_pessoa);
  }

  _updateNumberAlunos(id_turma) async {
    /**
        Método para atualizar o número de alunos da turma
     **/
    await id_turma.update({
      "number_Aluno": FieldValue.increment(1),
    });
  }

  addAluno(DocumentReference id_turma, id_pessoa) async {
    /**
        Método para adicionar informações do aluno na turma
     **/
    return await id_turma
        .collection("Alunos")
        .add({"destaques": 0, "aluno": id_pessoa});
  }

  Future<Turma> get_turma(DocumentSnapshot snapshot) async {
    Map<String, dynamic> json_turma = snapshot.data();
    Turma turma = Turma.fromJson(json_turma);

    Pessoa dados_professor =
    await PessoaController().get_user(json_turma["Professor"]);

    turma.Professor = dados_professor;

    return turma;
  }

  Turma fromJson(json_turma, json_user) {
    /**
     * Método que tranforma o Json de turma e professro em um objeto turma
     */

    Turma turma = Turma.fromJson(json_turma);
    Pessoa professor = Pessoa.fromJson(json_user);

    turma.Professor = professor;

    return turma;
  }

}
