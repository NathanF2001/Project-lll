import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';

class ChatController{

  add(DocumentReference ref,name, List<String> participantes) async{
    /**
     * Método para adicionar um Chat na turma
     */
    await ref.collection("Chat").add(
      {
        "nome": name,
        "alunos": participantes,
        "last_mensage": []
      }
    );
  }
  add_mensage(DocumentReference ref, String mensage,Pessoa pessoa,priority) async{
    /**
     * Método que adiciona uma mensagem a um Chat
     */
    final ref_mensage = await ref.collection("Log_mensage").add({
      "data": Timestamp.now(),
      "mensagem": mensage,
      "pessoa": pessoa.email,
      "destaque": false,
      "priority": (priority+1)
    });

    await updateLastMensage(ref, mensage,pessoa.nome);

  }

  updateLastMensage(ref_chat, mensage,pessoa) async{
    await ref_chat.update({
      "last_mensage": [mensage,pessoa],
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
  
  UpdateParticipantes(DocumentReference ref_chat,list_participantes) async{
    await ref_chat.update({"alunos": list_participantes});
  }
  
  UpdateNameChat(DocumentReference ref_chat,name) async{
    await ref_chat.update({"nome": name});
  }
}