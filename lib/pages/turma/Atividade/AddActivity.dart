import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class AddActivity extends StatefulWidget {
  Turma turma;
  List<Aluno> alunos;

  AddActivity(this.turma,this.alunos);

  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  Turma get turma => widget.turma;
  List<Aluno> get alunos => widget.alunos;
  GlobalKey<ScaffoldState> _scaffoldKeyActivity = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool exist = false;
  String titulo;
  String orientacao;
  String prazo_dia = "";
  String prazo_hora = "";
  List<String> links = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyActivity,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          turma.Nome,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _formAddActivity(),
    );
    ;
  }

  _formAddActivity() {
    return Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Utils.Text_input(
                hintmensage: "Insira o título da atividade",
                labelmensage: "Título *",
                maxLength: 60,
                validator: (String value) {
                  if (exist){
                    return "Esse titulo já existe na turma";
                  }
                  return  (value == "") | (value.length > 60) ? "Título inválido" : null;
                },
                onsaved: (value) => titulo = value,
              ),
              Utils.Text_input(
                hintmensage: "Insira a orientação da atividade",
                labelmensage: "Orientação *",
                validator: (String value) => value.isEmpty ? "Orientação inválida" : null,
                key_type: TextInputType.multiline,
                onsaved: (value) => orientacao = value,
              ),
              Utils.spaceMediumHeight,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 60,
                    child: Container(
                      child: InkWell(
                        onTap: (){
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime(2022))
                              .then((value) {
                              setState(() {
                                prazo_dia = "${value.day.toString().padLeft(2,'0')}/${value.month.toString().padLeft(2,'0')}/${value.year}";
                              });
                          },);
                              },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Prazo",style: TextStyle(fontSize: 24),),
                            Text(
                              prazo_dia == ""? "dd/mm/aaaa":
                                  prazo_dia,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 60,
                    child: Container(
                      child: InkWell(
                        onTap: (){
                          showTimePicker(context: context, initialTime: TimeOfDay(hour: 0, minute: 0))
                              .then((value){
                                setState(() {
                                  prazo_hora = "${value.hour.toString().padLeft(2,'0')}: ${value.minute.toString().padLeft(2,'0')}";
                                });
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Horário",style: TextStyle(fontSize: 24),),
                            Text(
                              prazo_hora == ""? "hh:mm":
                              prazo_hora,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ),
                  ),
                ],
              ),
              Utils.spaceBigHeight,
              Wrap(
                children: links.map((value) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      links.remove(value);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      color: Colors_myclass.black,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors_myclass.white,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete, color: Colors.white),
                          Spacer(),
                          Icon(Icons.delete, color: Colors.white),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                alignment: WrapAlignment.center,
              ),
              Container(
                width: 75,
                height: 50,
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    "Adicionar link",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    _showAlertDialog();
                  },
                ),
              ),
              Utils.spaceBigHeight,
              Buttons_myclass.Button1(context, colorbackground: Colors_myclass.black,
                  text: "Adicionar atividade", function: () async {
                    _formKey.currentState.save();

                    if((prazo_hora == "") | (prazo_dia == "")){
                      _scaffoldKeyActivity.currentState.showSnackBar(SnackBar(content: Text("Prazo inválido")));
                      return null;
                    }

                    QuerySnapshot activity = await turma.id.collection("Activity").where("titulo",isEqualTo: titulo).get();
                    exist = activity.docs.isNotEmpty;

                    bool valido = _formKey.currentState.validate();
                    if (!valido) {
                      return null;
                    }


                    // Adicionar atividade na turma
                    ActivityController atividade_controller = ActivityController(turma.id.collection("Activity"));
                    DocumentReference ref_atividade = await atividade_controller.add_activity(titulo, orientacao, links,prazo_dia,prazo_hora);

                    // Adiciona atividade para cada aluno
                    atividade_controller.addActivitiestoAlunos(ref_atividade,titulo,alunos);
                    Nav.pop(context);
                  })
            ],
          ),
        ));
  }

  _showAlertDialog() {
    final _formKeyLink = GlobalKey<FormState>();
    String link = "";
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Digite link que queira anexar",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Form(
            key: _formKeyLink,
            child: TextFormField(
              style: TextStyle(
                fontSize: 18,
              ),
              validator: (value) => value.isEmpty ? "Link inválido" : null,
              decoration: InputDecoration(
                  hintText: "Insira link para anexar",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),

                  labelText: "Link",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
              onSaved: (String value) {
                link = value;
              },
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                _formKeyLink.currentState.save();
                bool Linkvalido = _formKeyLink.currentState.validate();
                if (!Linkvalido) {
                  return ;
                }

                setState(() {
                  links.add(link);
                });

                Nav.pop(context);
              },
              child: Text("Adicionar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
