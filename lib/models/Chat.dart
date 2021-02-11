
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Mensage.dart';
import 'package:myclass/models/Pessoa.dart';

class Chat{
  List<Pessoa> alunos;
  String nome;
  List<dynamic> last_mensage;

  Chat(this.alunos, this.nome, this.last_mensage);

  Chat.fromJson(json){
    alunos = json["alunos"];
    nome = json["nome"];
    last_mensage = json["last_mensage"];
  }

  Map<String, dynamic> ToJson() => {
    "alunos": alunos,
    "nome": nome,
    "last_mensage": last_mensage,
  };
}