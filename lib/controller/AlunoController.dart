import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';

class AlunoController{

  addActivitytoAlunos(CollectionReference colref,String titulo){
    colref.get().then((value) => value.docs.forEach((element) {
      colref.doc(element.id).set({titulo: false,"${titulo}_links": [],"${titulo}_nota": ""},SetOptions(merge: true));
    }));
  }

  Future<int> getNumeroAlunos(DocumentReference ref) async{
    return await ref.collection("Alunos").snapshots().length;
  }

  send(DocumentReference ref,data,value,links) async{
    await ref.update({
      data: value
    });
    ref.set({"${data}_links": links},SetOptions(merge: true));
  }

  set_nota(Query ref,name_activity,nota) async {
    await ref.get().then((value) {
      value.docs.first.reference.update({
        "${name_activity}_nota": nota
      });
    });
    return true;
  }
  
  getbyref(DocumentReference ref_turma,DocumentReference ref_pessoa) async{
    return ref_turma.collection("Alunos").where("aluno",isEqualTo: ref_pessoa).get().then((value) => value.docs.first.data());
  }

  getAllAlunos(DocumentReference ref)async{
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

    List<Aluno> alunos_da_turma = [];

    await alunos.forEach((element) {
      element.then((value) => alunos_da_turma.add(value));
    });

    return alunos_da_turma;
  }
}