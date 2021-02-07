import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Chat.dart';
import 'package:myclass/models/Mensage.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class ChatPage extends StatefulWidget {
  DocumentReference user;
  DocumentReference professor;
  List<Aluno> alunos;
  Turma turma;

  ChatPage(this.user, this.professor, this.alunos, this.turma);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DocumentReference get user => widget.user;

  DocumentReference get prof => widget.professor;

  List<Aluno> get alunos => widget.alunos;

  List<dynamic> ref_alunos;

  Turma get turma => widget.turma;

  bool IsProfessor;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsProfessor = user.id == prof.id;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: turma.id.collection("Chat").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<dynamic> chats = snapshot.data.docs;

          if (chats.isEmpty){
            return IsProfessor ?
            Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Text(
                  "Adicionar bate-papo",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () => Nav.pushname(context, "/add-chat",
                    arguments: [turma, alunos]),
              ),
            ) :
              Container();
          }


          chats.add(chats.last);

          return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == (chats.length - 1)) {
                  if (IsProfessor) {
                    return InkWell(
                      child: Text(
                        "Adicionar bate-papo",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () => Nav.pushname(context, "/add-chat",
                          arguments: [turma, alunos]),
                    );
                  } else {
                    return Container();
                  }
                }

                Map<String, dynamic> chat = chats[index].data();
                ref_alunos = chat["alunos"];

                Map<String,Pessoa> alunos_chat = {};
                alunos.forEach((e) {
                  if (ref_alunos.contains(e.atividades["aluno"])){
                    alunos_chat[e.atividades["aluno"].id] = e.info;
                  };
                });

                alunos_chat["professor"] = turma.Professor;

                Mensage mensage = null;
                if (chat["last_mensage"] != null) {
                  mensage = Mensage.fromJson(chat["last_mensage"]);
                }


                Chat chat_config = Chat.fromJson({
                  "alunos": alunos_chat,
                  "last_mensage": mensage,
                  "nome": chat["nome"]
                });



                return Container(
                  margin: EdgeInsets.all(16),
                  height: 65,
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    title: Text(chat_config.nome,
                    style: TextStyle(color: Colors_myclass.white,fontSize: 24),),
                    dense: true,
                    subtitle: chat_config.last_mensage != null ?
                    Text(
                      "${chat_config.last_mensage.pessoa.nome}: ${chat_config.last_mensage.mensagem}",
                      overflow: TextOverflow.ellipsis,
                    ): Text("New chat",
                      style: TextStyle(color: Colors_myclass.white,fontSize: 16),),
                    onTap: () =>
                        IsProfessor ?
                        Nav.pushname(context, "/mensage-prof-page", arguments: [chat_config,chats[index].reference,user])
                    :
                        Nav.pushname(context, "/mensage-page", arguments: [chat_config,chats[index].reference,user]),
                  ),
                );
              });
        });
  }
}
