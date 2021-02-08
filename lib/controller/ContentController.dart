import 'package:cloud_firestore/cloud_firestore.dart';

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
}