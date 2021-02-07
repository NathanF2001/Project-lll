import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Alunos.dart';

class ChatController{

  add(DocumentReference ref,name, List<Aluno> students) async{
    await ref.collection("Chat").add(
      {
        "nome": name,
        "alunos": students.map((e) => e.atividades["aluno"]).toList(),
        "last_mensage": null
      }
    );
  }
  //DateTime.now().millisecondsSinceEpoch,
  add_mensage(DocumentReference ref, String mensage,pessoa,priority) async{
    await ref.collection("Log_mensage").add({
      "data": Timestamp.now(),
      "mensagem": mensage,
      "pessoa": pessoa,
      "destaque": false,
      "priority": (priority+1)
    });
  }

  set_destaque(DocumentReference ref,status) async{
    await ref.update({
      "destaque": !status,
    });
  }
}