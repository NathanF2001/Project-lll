import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/ActivityAluno.dart';
import 'package:myclass/models/Pessoa.dart';

class Aluno{
  Map<String,ActivityAluno> atividades;
  DocumentReference ref_pessoa;
  Pessoa info;

  Aluno(this.atividades,this.ref_pessoa, this.info);

  Aluno.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    atividades = json["atividades"];
    ref_pessoa = json["aluno"];
  }

  Map<String, dynamic> ToJson() => {
    "atividades": atividades,
    "aluno": ref_pessoa
  };
}