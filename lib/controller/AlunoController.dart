import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/ActivityAluno.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/SocialEconomico.dart';

class AlunoController{



  send(DocumentReference activityref,DocumentReference refaluno,status_send,links) async{
    /**
     * Método quando Aluno envia alguma atividade, com seus respectivos links
     */
    // Atualiza o status se mandou a atividade

    DocumentReference ref_acitivtyaluno = await activityref.collection("Atividade alunos").where("aluno",isEqualTo: refaluno).get().then((value) => value.docs.first.reference);

    await ref_acitivtyaluno.update({
      "enviado": status_send,
      "links": links,
    });

  }

  Future<DocumentReference> get_ref(DocumentReference id_turma,id_user) async {
    return await id_turma.collection("Alunos").where("aluno", isEqualTo: id_user).get().then((value) => value.docs.first.reference);
  }

  set_nota(DocumentReference ref_activity,nota) async {
    /**
      Método que muda a nota do Aluno
     **/


    ref_activity.update({
        "nota": nota
      });
    return true;
  }

  set_destaque(DocumentReference ref_aluno,value) async{
  ref_aluno.update({"destaques": FieldValue.increment(value)});
  }

  deleteAluno(DocumentReference ref_turma,ref_pessoa) async{
    DocumentReference ref_aluno = await ref_turma.collection("Alunos").where("aluno",isEqualTo: ref_pessoa).get().then((value) => value.docs.first.reference);

    ref_aluno.delete();
    return ref_aluno;
  }

  Future<Aluno> fromJson( DocumentSnapshot snapshot,List<Activity> atividades) async{
    final json_aluno = snapshot.data();


    Aluno aluno = Aluno.fromJson({"aluno":snapshot.reference});
    Pessoa pessoa = await PessoaController().get_user(json_aluno["aluno"]);
    aluno.info = pessoa;
    aluno.destaques = json_aluno["destaques"];

    return aluno;
  }

   getAllAlunos(DocumentReference ref_turma,List<Activity> atividades)async{
    /**
      Método que retorna uma lista com todos alunos da turma
     **/


     // Fazendo requisição ao banco pegar todos os alunos
     final documents = await ref_turma.collection("Alunos").get();
     List<Future<Aluno>> future_alunos = documents.docs.map((snapshot) async {
       Aluno aluno = await fromJson(snapshot, atividades);
       return aluno;
     }).toList();

    List<Aluno> alunos = await  Future.wait(future_alunos);


    return alunos;
  }


}