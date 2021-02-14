import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/ActivityAluno.dart';
import 'package:myclass/models/Pessoa.dart';

class Aluno{
  DocumentReference ref_pessoa;
  int destaques;
  Pessoa info;

  Aluno(this.ref_pessoa, this.info);

  Aluno.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    ref_pessoa = json["aluno"];
    destaques = json["destaques"];
  }

  Map<String, dynamic> ToJson() => {
    "aluno": ref_pessoa
  };
}