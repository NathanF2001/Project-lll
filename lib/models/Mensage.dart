import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';

class Mensage{
  Pessoa pessoa;
  String mensagem;
  DateTime data;
  bool destaque;

  Mensage(this.pessoa, this.mensagem, this.data);

  Mensage.fromJson(json){
    pessoa = json["pessoa"];
    mensagem = json["mensagem"];
    data = json["data"];
    destaque = json["destaque"];
  }

  Map<String, dynamic> ToJson() => {
    "pessoa": pessoa,
    "mensagem": mensagem,
    "data": data,
    "destaque": destaque
  };
}