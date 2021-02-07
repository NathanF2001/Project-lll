import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/controller/ChatController.dart';
import 'package:myclass/models/Chat.dart';
import 'package:myclass/models/Mensage.dart';
import 'package:myclass/nav.dart';

class MensageProfPage extends StatefulWidget {
  @override
  _MensageProfPageState createState() => _MensageProfPageState();
}

class _MensageProfPageState extends State<MensageProfPage> {
  DocumentReference user;
  Chat chat;
  DocumentReference ref_chat;
  String send_mensage;
  int priority;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<dynamic> values = Nav.getRouteArgs(context);
    chat = values[0];
    ref_chat = values[1];
    user = values[2];
    print(chat.alunos);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          chat.nome,
          style: TextStyle(color: Colors.white),
        ),
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
                      final pessoa = chat.alunos[mensage_map["pessoa"]];
                      final mensagem = mensage_map["mensagem"];
                      final data = mensage_map["data"];
                      if (index == 0){
                        priority = mensage_map["priority"];
                      }


                      Mensage mensage = Mensage.fromJson({
                        "pessoa": pessoa,
                        "mensagem": mensagem,
                        "data": data.toDate(),
                        "destaque": mensage_map["destaque"],
                      });


                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: (mensage_map["pessoa"] == "professor")
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
                                  child: IconButton(icon: Icon(Icons.star,color: mensage.destaque ? Colors.yellow : Colors.black,), onPressed: (){
                                ChatController().set_destaque(log_mensage[index].reference,mensage.destaque);

                              }))
                            ],
                          )
                      );;
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

                          ChatController().add_mensage(ref_chat, send_mensage, "professor",
                              log_mensage == [] ? 0 : priority);
                          _formKey.currentState.reset();
                        }))
                  ],
                ),
              )
            ],
          );
        });
  }
}
