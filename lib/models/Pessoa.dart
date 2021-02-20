import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/SocialEconomico.dart';


class Pessoa{
  String email;
  String nome;
  String instituicao;
  String descricao;
  String UrlFoto;
  List<dynamic> Turmas_reference;
  SocialEconomico ref_SE;
  int classificacao;

  Pessoa(this.email, this.nome, this.instituicao, this.descricao, this.UrlFoto,this.Turmas_reference,this.ref_SE,this.classificacao);


  Pessoa.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    email = json["email"];
    nome = json["nome"];
    instituicao = json["instituicao"];
    descricao = json["descricao"];
    UrlFoto = json["UrlFoto"];
    Turmas_reference = json["Turmas_reference"];
    classificacao = json["classificação"];
  }

  Map<String, dynamic> ToJson() => {
    "email": email,
    "nome": nome,
    "instituicao": instituicao,
    "descricao": descricao,
    "UrlFoto": UrlFoto,
    "Turmas_reference": Turmas_reference,
    "classificação": classificacao
  };

  add_turma(turma){
    Turmas_reference.add(turma);
  }
}