import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Chat.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/turma/Chat/AddChat.dart';
import 'package:myclass/pages/turma/Chat/TalkPage.dart';
import 'package:myclass/pages/turma/Chat/TalkPageProf.dart';

class ChatPage extends StatefulWidget {
  Pessoa user;
  List<Aluno> alunos;
  Turma turma;

  ChatPage(this.user, this.alunos, this.turma);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Pessoa get user => widget.user;

  List<Aluno> get alunos => widget.alunos;

  List<dynamic> ref_alunos;

  Turma get turma => widget.turma;

  bool IsProfessor;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsProfessor = user.email == turma.Professor.email;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: turma.id.collection("Chat").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if ((!snapshot.hasData) | (snapshot.connectionState == ConnectionState.waiting)) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          List<DocumentSnapshot> chats = snapshot.data.docs;


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
                onTap: () => Nav.push(context, AddChat(turma, alunos)),
              ),
            ) :
            Container();
          }

          // Opção para adicionar botão de adicionar bate-papo
          chats.add(chats.last);

          return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                // Botão do professor de adicionar turma
                if (index == (chats.length - 1)) {
                  if (IsProfessor) {
                    return InkWell(
                      child: Text(
                        "Adicionar bate-papo",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () => Nav.push(context, AddChat(turma, alunos)),
                    );
                  } else {
                    return Container();
                  }
                }

                Map<String, dynamic> chat = chats[index].data();
                ref_alunos = chat["alunos"];

                // Caso o aluno não pertence a turma
                if (!IsProfessor & !ref_alunos.contains(user.email)){

                  return Container();
                }
                
                List<Pessoa> alunos_turma = alunos.where((element) => ref_alunos.contains(element.info.email)).map((e) => e.info).toList();
                alunos_turma.add(turma.Professor);


                // Ultima mensagem
                List<dynamic> mensage = chat["last_mensage"];


                Chat chat_config = Chat.fromJson({
                  "alunos": alunos_turma,
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
                    subtitle: chat_config.last_mensage.isNotEmpty ?
                    Text(
                      "${chat_config.last_mensage[1]}: ${chat_config.last_mensage[0]}",
                      style: TextStyle(color: Colors_myclass.white,fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ): Text("New chat",
                      style: TextStyle(color: Colors_myclass.white,fontSize: 16),),
                    onTap: () =>
                    IsProfessor ?
                    Nav.push(context, MensageProfPage(chat_config,chats[index].reference,user,turma,alunos))
                        :
                    Nav.push(context, MensagePage(chat_config,chats[index].reference,user)),
                  ),
                );
              });
        });
  }
}
