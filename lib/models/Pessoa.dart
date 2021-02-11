import 'package:cloud_firestore/cloud_firestore.dart';


class Pessoa{
  String email;
  String nome;
  String instituicao;
  String descricao;
  String UrlFoto;
  List<dynamic> Turmas_reference;

  Pessoa(this.email, this.nome, this.instituicao, this.descricao, this.UrlFoto,this.Turmas_reference);


  Pessoa.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    email = json["email"];
    nome = json["nome"];
    instituicao = json["instituicao"];
    descricao = json["descricao"];
    UrlFoto = json["UrlFoto"];
    Turmas_reference = json["Turmas_reference"];
  }

  Map<String, dynamic> ToJson() => {
    "email": email,
    "nome": nome,
    "instituicao": instituicao,
    "descricao": descricao,
    "UrlFoto": UrlFoto,
    "Turmas_reference": Turmas_reference
  };

  add_turma(turma){
    Turmas_reference.add(turma);
  }
}