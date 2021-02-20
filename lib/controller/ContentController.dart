import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Content.dart';

class ContentController{

  CollectionReference _content;

  ContentController(this._content);

  add_content(titulo,descricao,anexo) async{
    /**
     * Método para criar conteúdo
     */
    await _content.add({
      "titulo": titulo,
      "orientacao": descricao,
      "anexo": anexo,
      "data": "${DateTime.now().toLocal().day.toString().padLeft(2,'0')}/${DateTime.now().toLocal().month.toString().padLeft(2,'0')}/${DateTime.now().toLocal().year}"
    });

    return true;
  }
  
  Future<DocumentSnapshot> get_content( titulo) async{
    /**
     * Método para pegar conteudo pelo titulo (ID de conteudo)
     */
    try{
      return await _content.where("titulo",isEqualTo: titulo).get().then((value) => value.docs.first);
    } catch(e){
      if (e.toString() =="Bad state: No element" ){
        return null;
      }
      throw Exception("Ocorreu um erro: ${e}");

    }
  }

  update_content(DocumentReference ref_content, Content conteudo) async{
    await ref_content.update(conteudo.ToJson());

  }
}