import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/controller/ChatController.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Chat.dart';
import 'package:myclass/models/Mensage.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/turma/Chat/AddMoreAlunos.dart';

class MensageProfPage extends StatefulWidget {
  Chat chat;
  DocumentReference ref_chat;
  Pessoa user;
  Turma turma;
  List<Aluno> alunos;

  MensageProfPage(this.chat, this.ref_chat,this.user,this.turma,this.alunos);

  @override
  _MensageProfPageState createState() => _MensageProfPageState();
}

class _MensageProfPageState extends State<MensageProfPage> {
  Chat get chat => widget.chat;
  DocumentReference get ref_chat => widget.ref_chat;
  Pessoa get user => widget.user;
  Turma get turma => widget.turma;
  List<Aluno> get alunos => widget.alunos;

  String send_mensage;
  int priority;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          chat.nome,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: PopupMenuButton(
              onSelected: (value) async{
                if (value == "Adicionar aluno") {
                  List<Aluno> alunos_chat = await Nav.push(context, AddMoreAlunos(alunos,chat,turma));
                  if(alunos_chat != null){
                    chat.alunos = alunos_chat.map((e) => e.info).toList();
                    chat.alunos.add(turma.Professor);
                    List<String> emails_participantes = chat.alunos.map((e) => e.email).toList();
                    ChatController().UpdateParticipantes(ref_chat, emails_participantes);
                    setState(() {});
                  }
                }else{
                  //Listar as informações da turma
                  _showAlertDialog();
                }
              },
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                    value: "Adicionar aluno",
                    child: Text("Adicionar aluno")),
                PopupMenuItem(
                    value: "Mudar nome do chat",
                    child: Text("Mudar nome do chat")),
              ],
              child: Icon(Icons.more_vert),
            ),
          )
        ],
      ),

      body: _Mensage(),
    );
  }

  _Mensage() {

    return StreamBuilder(
        stream: ref_chat.collection("Log_mensage").orderBy("priority",descending: true).snapshots(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<dynamic> log_mensage = snapshot.data.docs;

          return Column(
            children: [
              Expanded(
                flex: 5,
                child: ListView.builder(
                    itemCount: log_mensage.length,
                    reverse: true,
                    itemBuilder: (context, index) {


                      final mensage_map = log_mensage[index].data();

                      final pessoa = mensage_map["pessoa"];
                      final mensagem = mensage_map["mensagem"];
                      final data = mensage_map["data"];
                      if (index == 0){
                        priority = mensage_map["priority"];
                      }
                      Mensage mensage = Mensage.fromJson({
                        "pessoa": chat.alunos.where((element) => element.email == pessoa).first,
                        "mensagem": mensagem,
                        "data": data.toDate(),
                        "destaque": mensage_map["destaque"],
                      });


                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: (mensage.pessoa.email == user.email)
                              ? Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(top: 8, bottom: 8, left: 80),
                              padding: EdgeInsets.only(right: 16,bottom: 16,left: 8),
                              decoration: BoxDecoration(
                                color: Color(0xC8383D3B),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${mensage.data.hour.toString().padLeft(2,"0")}:${mensage.data.minute.toString().padLeft(2,"0")}",
                                        style: TextStyle(color: Colors_myclass.white,fontSize: 18,fontWeight: FontWeight.w200),),
                                      Text(
                                        "Você",
                                        style: TextStyle(color: Colors_myclass.white,fontSize: 20,fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Text(mensage.mensagem,
                                    style: TextStyle(color: Colors_myclass.white,fontSize: 18,fontWeight: FontWeight.w300),)
                                ],
                              ))
                              : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 8,bottom: 16,right: 8),
                                    margin: EdgeInsets.only(top: 8, bottom: 8),
                                    decoration: BoxDecoration(
                                      color: Colors_myclass.black,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              mensage.pessoa.nome,
                                              style: TextStyle(color: Colors_myclass.white,fontSize: 24,fontWeight: FontWeight.w500),
                                            ),
                                            Text("${mensage.data.hour.toString().padLeft(2,"0")}:${mensage.data.minute.toString().padLeft(2,"0")}",
                                              style: TextStyle(color: Colors_myclass.white,fontSize: 18,fontWeight: FontWeight.w200),),
                                          ],
                                        ),
                                        Text(mensage.mensagem,
                                          style: TextStyle(color: Colors_myclass.white,fontSize: 18,fontWeight: FontWeight.w300),)
                                      ],
                                    )),),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(top:16),
                                    child: IconButton(icon: Icon(Icons.star,color: mensage.destaque ? Colors.yellow : Colors.black,), onPressed: () async{

                                      // Mudar destaque na mensagem
                                      ChatController().set_destaque(log_mensage[index].reference,mensage.destaque);

                                      // Pegar referencia da pessoa que foi destacada
                                      DocumentReference ref_pessoa = await PessoaController().getref(mensage.pessoa.email);

                                      // Pegar referencia aluno da pessoa destacada
                                      DocumentReference ref_aluno = await AlunoController().get_ref(turma.id, ref_pessoa);

                                      // Mudar a quantidade de destaque do aluno
                                      await AlunoController().set_destaque(ref_aluno, !mensage.destaque == true ? 1 : -1);

                                    }),
                                  ))
                            ],
                          ),
                      );
                    }),
              ),
              Container(
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16),
                          child: Form(
                            key: _formKey,

                            child: TextFormField(
                              initialValue: "",
                              onSaved: (value) => send_mensage = value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                  ),
                                  hintText: "Enviar"),
                            ),
                          )
                      ),
                    ),
                    Expanded(
                      child:
                      IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                    ),
                    Expanded(
                        child: IconButton(
                            icon: Icon(Icons.send_sharp), onPressed: () {
                          _formKey.currentState.save();

                          ChatController().add_mensage(ref_chat, send_mensage, user,
                              log_mensage.isEmpty ? 0 : priority);
                          _formKey.currentState.reset();
                        }))
                  ],
                ),
              )
            ],
          );
        });
  }

  _showAlertDialog() {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Nome do chat",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              style: TextStyle(
                fontSize: 18,
              ),
              initialValue: chat.nome,
              decoration: InputDecoration(
                  hintText: "Insira nome do chat",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  labelText: "Nome do chat",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
              onSaved: (String value) {
                chat.nome = value;
              },
              validator: (value) => value == "" ? "Nome inválido (vazio)" : null,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {

                bool validate = _formKey.currentState.validate();
                if (!validate){
                  return ;
                }
                _formKey.currentState.save();

                ChatController().UpdateNameChat(ref_chat, chat.nome);
                setState(() {

                });

                Nav.pop(context,result: true);
              },
              child: Text("Entrar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
