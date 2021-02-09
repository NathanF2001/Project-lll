import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';

class AlunoController{



  send(DocumentReference referenceAluno,name_activity,status_send,links) async{
    /**
     * Método quando Aluno envia alguma atividade, com seus respectivos links
     */
    // Atualiza o status se mandou a atividade


    await referenceAluno.update({
      name_activity: status_send
    });

    referenceAluno.set({"${name_activity}_links": links},SetOptions(merge: true));
  }

  Future<QueryDocumentSnapshot> get_ref(DocumentReference id_turma,id_user) async {
    return await id_turma.collection("Alunos").where("aluno", isEqualTo: id_user).get().then((value) => value.docs.first);
  }

  set_nota(id_turma,id_user,name_activity,nota) async {
    /**
      Método que muda a nota do Aluno
     **/

    QueryDocumentSnapshot doc = await get_ref(id_turma, id_user);
    doc.reference.update({
        "${name_activity}_nota": nota
      });
    return true;
  }
  
  getbyref(DocumentReference ref_turma,DocumentReference ref_pessoa) async{
    /**
     * Método que retorna os dados do Aluno dando sua referência de Users
     */
    return ref_turma.collection("Alunos").where("aluno",isEqualTo: ref_pessoa).get().then((value) => value.docs.first.data());
  }

  Future<Aluno> fromJson(DocumentReference ref_turma,DocumentReference ref_pessoa,Pessoa user) async{
    final info_aluno = await getbyref(ref_turma, ref_pessoa);
    Aluno aluno = Aluno.fromJson({"atividades": info_aluno});
    aluno.info = user;

    return aluno;
  }

   getAllAlunos(DocumentReference ref)async{
    /**
      Método que retorna uma lista com todos alunos da turma
     **/

     // Fazendo requisição ao banco pegar todos os alunos
     List<Future<Aluno>> alunos = await ref.collection("Alunos").get()
         .then((document)async => await document.docs.map((element) async {
       final data = element.data();
       Aluno aluno = Aluno.fromJson({
         "atividades": data,
       });
       

       DocumentSnapshot ref_pessoa = await data["aluno"].get();
       Pessoa pessoa = Pessoa.fromJson(ref_pessoa.data());

       aluno.info = pessoa;

       return aluno;
     }).toList());

    //Tranformando todos alunos que estão em Future<Aluno> para Aluno
    List<Aluno> alunos_da_turma = [];

    await alunos.forEach((element) {
      element.then((value) => alunos_da_turma.add(value));
    });

    return alunos_da_turma;
  }

  Map<String,Pessoa> MappingAlunos(alunos){
    /**
     * Método  map do Objeto Pessoa de cada aluno, ele serve para que não precise fazer uma chamada nas informações dos alunos
     * pois estas já foram declaradas
     */

    final map_aluno = {};

    alunos.forEach((aluno) {
      map_aluno[aluno.atividades["aluno"].id]= aluno.info;
    });

    return map_aluno;
  }


}