import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Alunos.dart';

class ChatController{

  add(DocumentReference ref,name, List<Aluno> students) async{
    /**
     * Método para adicionar um Chat na turma
     */
    await ref.collection("Chat").add(
      {
        "nome": name,
        "alunos": students.map((e) => e.atividades["aluno"]).toList(),
        "last_mensage": null
      }
    );
  }
  add_mensage(DocumentReference ref, String mensage,pessoa,priority) async{
    /**
     * Método que adiciona uma mensagem a um Chat
     */
    await ref.collection("Log_mensage").add({
      "data": Timestamp.now(),
      "mensagem": mensage,
      "pessoa": pessoa,
      "destaque": false,
      "priority": (priority+1)
    });
  }

  set_destaque(DocumentReference ref,status) async{
    /**
     * Método que muda o status de favoritar uma mensagem
     */
    await ref.update({
      "destaque": !status,
    });
  }
}