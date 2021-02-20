import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WebService{
  getClassifier(url,Pessoa user,DocumentReference id_user) async{
    try{
      if (url == "/classify?"){
        return null;
      }

      Map<String,String>json_values = {
        "Idade_intervalos": user.ref_SE.idade_intervalo,
        "Estado_civil": user.ref_SE.estado_civil,
        "Raça_cor": user.ref_SE.raca_cor,
        "Escolaridade_pai": user.ref_SE.escolaridade_pai,
        "Escolaridade_mae": user.ref_SE.escolaridade_mae,
        "Renda_familia": user.ref_SE.renda_familia,
        "Situacao_financeira": user.ref_SE.situacao_financeira,
        "Situacao_trabalho": user.ref_SE.situacao_trabalho,
        "Bolsa_estudo": user.ref_SE.bolsa_estudo,
        "Bolsa_academica": user.ref_SE.bolsa_academica,
        "Atividade_exterior": user.ref_SE.atividade_exterior,
        "Ingresso_cota": user.ref_SE.ingresso_cota,
        "Incentivou_graduacao": user.ref_SE.incetivou_graduacao,
        "Estudo_idioma": user.ref_SE.estudo_idioma,
        "Motivo_curso": user.ref_SE.motivo_curso
      };

      String new_url = "${url}values=${json.encode(json_values)}";

      final response = await http.get(new_url);

      if((response.statusCode < 200) | (response.statusCode > 204)){
        return null;
      }

      int classificacao = int.parse(response.body) + 1;
      await PessoaController().update_classifier(id_user, classificacao);
      return classificacao;
    }catch(e){
      return null;
    }

  }

  get_chats(n_alunos,List<Aluno>alunos,link_webservice) async{
    n_alunos = int.parse(n_alunos);

    final peso_alunos = {};
    alunos.forEach((element) {peso_alunos[element.info.email] = element.info.classificacao;});

    String new_url = "${link_webservice}agroup?alunos=${json.encode(peso_alunos)}&max=${n_alunos}";

    final response = await http.get(new_url);
    if((response.statusCode < 200) | (response.statusCode > 204)){
      return null;
    }

    List<dynamic> list_json = json.decode(response.body);
    print(list_json);
    List<Map<String,int>> list_map = list_json.map((e) => Map<String,int>.from(e)).toList();

    List<List<String>> chats = list_map.map((json) => json.keys.toList()).toList();

    return chats;
  }
}