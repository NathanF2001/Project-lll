import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Pessoa.dart';

class Turma{
  String Nome;
  String Descricao;
  String CodTurma;
  String UrlTurma;
  Pessoa Professor;
  String codigo;
  int number_Aluno;
  DocumentReference id;

  Turma(this.Nome, this.Descricao, this.CodTurma,
      this.UrlTurma, this.Professor,this.id);

  Turma.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    Nome = json["Nome"];
    Descricao = json["Descricao"];
    CodTurma = json["CodTurma"];
    UrlTurma = json["UrlTurma"];
    number_Aluno = json["number_Aluno"];
    codigo = json["codigo"];
  }

  Map<String, dynamic> ToJson() => {
  "Nome": Nome,
  "Descricao" : Descricao,
  "CodTurma": CodTurma,
  "UrlTurma": UrlTurma,
    "number_Aluno": number_Aluno,
    "codigo": codigo,
  };



}