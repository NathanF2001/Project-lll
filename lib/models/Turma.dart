import 'package:cloud_firestore/cloud_firestore.dart';

class Turma{
  String Nome;
  String Descricao;
  String Modalidade;
  String CodTurma;
  String UrlTurma;
  String Professor;
  DocumentReference id;

  Turma(this.Nome, this.Descricao, this.Modalidade, this.CodTurma,
      this.UrlTurma, this.Professor,this.id);

  Turma.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    Nome = json["Nome"];
    Descricao = json["Descricao"];
    Modalidade = json["Modalidade"];
    CodTurma = json["CodTurma"];
    UrlTurma = json["UrlTurma"];
    Professor = json["Professor"];
    id = json["id"];
  }

  Map<String, dynamic> ToJson() => {
  "Nome": Nome,
  "Descricao" : Descricao,
  "Modalidade": Modalidade,
  "CodTurma": CodTurma,
  "UrlTurma": UrlTurma,
  "Professor": Professor,
    "id": id
  };



}