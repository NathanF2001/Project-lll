import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:http/http.dart' as http;

class WebService{
  getClassifier(url,Pessoa user,DocumentReference id_user) async{


    String new_url = "${url}Idade_intervalos=${user.ref_SE.idade_intervalo}&";
    new_url = "${new_url}Estado_civil=${user.ref_SE.estado_civil}&";
    new_url = "${new_url}Raça_cor=${user.ref_SE.raca_cor}&";
    new_url = "${new_url}Escolaridade_pai=${user.ref_SE.escolaridade_pai}&";
    new_url = "${new_url}Escolaridade_mae=${user.ref_SE.escolaridade_mae}&";
    new_url = "${new_url}Renda_familia=${user.ref_SE.renda_familia}&";
    new_url = "${new_url}Situacao_financeira=${user.ref_SE.situacao_financeira}&";
    new_url = "${new_url}Situacao_trabalho=${user.ref_SE.situacao_trabalho}&";
    new_url = "${new_url}Bolsa_estudo=${user.ref_SE.bolsa_estudo}&";
    new_url = "${new_url}Bolsa_academico=${user.ref_SE.bolsa_academica}&";
    new_url = "${new_url}Atividade_exterior=${user.ref_SE.atividade_exterior}&";
    new_url = "${new_url}Ingresso_cota=${user.ref_SE.ingresso_cota}&";
    new_url = "${new_url}Incetivou_graduacao=${user.ref_SE.incetivou_graduacao}&";
    new_url = "${new_url}Estudo_idioma=${user.ref_SE.estudo_idioma}&";
    new_url = "${new_url}Motivo_curso=${user.ref_SE.motivo_curso}";

    print(new_url);
    final response = await http.get(new_url);
    print(response.body);
    if((response.statusCode < 200) | (response.statusCode > 204)){
      return null;
    }
    user.classificacao = response.body;

    await PessoaController().update_classifier(id_user, user.classificacao);
    return user;

  }
}