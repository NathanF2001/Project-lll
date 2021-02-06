import 'package:myclass/models/Pessoa.dart';

class Aluno{
  Map<String,dynamic> atividades;
  Pessoa info;

  Aluno(this.atividades, this.info);

  Aluno.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    atividades = json["atividades"];
  }

  Map<String, dynamic> ToJson() => {
    "atividades": atividades,
  };
}