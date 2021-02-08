import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';

class TurmaController {
  final _user = FirebaseFirestore.instance;

  create_turma(json,Pessoa pessoa,id_professor) async {

    /**
      Método para criar turma
     **/
    json["UrlTurma"] = pessoa.UrlFoto;
    json["Professor"] = id_professor;
    json["Alunos"] = [];
    json["number_Aluno"] = 0;

    List<dynamic> turmas = pessoa.Turmas_reference;

    DocumentReference ref = await _user.collection("Turmas").add({});
    pessoa.add_turma(ref);

    json["id"] = ref;

    _user.collection("Turmas").doc(ref.id).set(json);

    _user
        .collection("Users")
        .doc(id_professor)
        .update({"Turmas_reference": pessoa.Turmas_reference});

    return pessoa;
  }

  get_turmabycode(code)async{
    /**
      Método de um aluno recuperar referencia da turma que ele colocou codigo
    **/
    return await _user.collection("Turmas").where("codigo",isEqualTo: code).get();
  }

  addAlunoTurma(DocumentReference id_turma,Turma turma,id_pessoa) async{
    /**
      Método para adicionar um aluno na turma
     **/
    await _updateNumberAlunos(id_turma);
    return await _addAluno(id_turma,id_pessoa);
  }

  _updateNumberAlunos(id_turma) async {
    /**
      Método para atualizar o número de alunos da turma
     **/
    await id_turma.update({
      "number_Aluno": FieldValue.increment(1),
    });
  }

  _addAluno(DocumentReference id_turma,id_pessoa) async{
    /**
      Método para adicionar informações do aluno na turma
     **/
   return await id_turma.collection("Alunos").add({"Atividades_entregues": 0,
      "aluno": id_pessoa});
  }


}
