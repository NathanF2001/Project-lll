import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityController{

  CollectionReference _content;

  ActivityController(this._content);

  add_activity(titulo,descricao,anexo,prazo_dia,prazo_hora) async{
    await _content.add({
      "titulo": titulo,
      "orientacao": descricao,
      "anexo": anexo,
      "prazo_dia": prazo_dia,
      "prazo_hora": prazo_hora,
      "enviados": 0,
    });

    return true;
  }

  add_send(ref,number){
    ref.update({
      "enviados": FieldValue.increment(number)
    });
  }

  getAllActivities()async{
    return _content.get().then((value) => value.docs);
  }


}