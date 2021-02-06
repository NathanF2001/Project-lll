import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Alunos.dart';

class ChatController{

  add(DocumentReference ref,name, List<Aluno> students) async{
    await ref.collection("Chat").add(
      {
        "nome": name,
        "alunos": students.map((e) => e.atividades["aluno"]).toList()
      }
    );
  }
}