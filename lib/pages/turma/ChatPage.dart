import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class ChatPage extends StatefulWidget {
  DocumentReference user;
  DocumentReference professor;
  List<Future<Aluno>> alunos;
  Turma turma;


  ChatPage(this.user,this.professor,this.alunos,this.turma);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  DocumentReference get user => widget.user;
  DocumentReference get prof => widget.professor;
  List<Future<Aluno>> get alunos => widget.alunos;
  Turma get turma => widget.turma;

  bool IsProfessor;

  List<Map<String,dynamic>> chats = [
    {
      "title": "Chat geral",
      "current_mensage": ["Aluno","Alguém sabe fazer a questão 1???"],
      "unread_mensage": 15
    },
    {
      "title": "Grupo A",
      "current_mensage": ["Aluno","Talvez tenha que perguntar ao professor sobre essa dúvida"],
      "unread_mensage": 4
    },
    {
      "title": "Grupo B",
      "current_mensage": ["Aluno","Está tudo certo então, vamos nós reunir e decidir tudo"],
      "unread_mensage": 0
    },
    {"type": "Add-button"}
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    IsProfessor = user.id == prof.id;
  }

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: chats.length,
        itemBuilder: (BuildContext context,int index){
          Map<String,dynamic> chat = chats[index];
          if (index == (chats.length-1) ){
            if (IsProfessor){
              return InkWell(
                child: Text("Adicionar bate-papo",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),
                onTap: () => Nav.pushname(context, "/add-chat",arguments: [turma,alunos]),
              );
            }else{
              return Container();
            }
          }
          return Container(
            margin: EdgeInsets.all(16),

            decoration: BoxDecoration(
                color: Color(0x4002CD5D),
                borderRadius: BorderRadius.circular(20)
            ),
            child: ListTile(
                title: Text(chat["title"]),
                dense: true,
                subtitle: Text("${chat["current_mensage"][0]}: ${chat["current_mensage"][1]}",overflow: TextOverflow.ellipsis,),
                trailing: chat["unread_mensage"] != 0 ?
                Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Text("${chat["unread_mensage"]}"),
                )
                    :
                null,
              onTap: () => Nav.pushname(context, "/mensage-page",arguments: 1),
            ),
          );
    });
  }
}
