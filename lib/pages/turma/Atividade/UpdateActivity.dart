import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class UpdateActivity extends StatefulWidget {
  Turma turma;
  Activity atividade;

  UpdateActivity(this.turma,this.atividade);

  @override
  _UpdateActivityState createState() => _UpdateActivityState();
}

class _UpdateActivityState extends State<UpdateActivity> {
  Turma get turma => widget.turma;
  Activity get atividade => widget.atividade;

  GlobalKey<ScaffoldState> _scaffoldKeyActivity = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String old_titulo;

  bool exist = false;

  @override
  void initState() {

    super.initState();
    old_titulo = atividade.titulo;
  }

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
                initialvalue: atividade.titulo,
                validator: (String value) {
                  if (exist){
                    return "Esse titulo já existe na turma";
                  }
                  return  (value == "") | (value.length > 60) ? "Título inválido" : null;
                },
                onsaved: (value) => atividade.titulo = value,
              ),
              Utils.Text_input(
                hintmensage: "Insira a orientação da atividade",
                labelmensage: "Orientação *",
                initialvalue: atividade.orientacao,
                validator: (String value) => value.isEmpty ? "Orientação inválida" : null,
                key_type: TextInputType.multiline,
                onsaved: (value) => atividade.orientacao = value,
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
                                atividade.prazo_dia = "${value.day.toString().padLeft(2,'0')}/${value.month.toString().padLeft(2,'0')}/${value.year}";
                              });
                            },);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Prazo",style: TextStyle(fontSize: 24),),
                              Text(
                                atividade.prazo_dia == ""? "dd/mm/aaaa":
                                atividade.prazo_dia,
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
                                atividade.prazo_hora = "${value.hour.toString().padLeft(2,'0')}: ${value.minute.toString().padLeft(2,'0')}";
                              });
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Horário",style: TextStyle(fontSize: 24),),
                              Text(
                                atividade.prazo_hora == ""? "hh:mm":
                                atividade.prazo_hora,
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
                children: atividade.anexo.map((value) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      atividade.anexo.remove(value);
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
                  text: "Atualizar atividade", function: () async {
                    _formKey.currentState.save();

                    if((atividade.prazo_hora == "") | (atividade.prazo_dia == "")){
                      _scaffoldKeyActivity.currentState.showSnackBar(SnackBar(content: Text("Prazo inválido")));
                      return null;
                    }

                    QuerySnapshot activity = await turma.id.collection("Activity").where("titulo",isEqualTo: atividade.titulo).get();
                    exist = (activity.docs.isNotEmpty) & (old_titulo != atividade.titulo);

                    bool valido = _formKey.currentState.validate();
                    if (!valido) {
                      return null;
                    }


                    // Adicionar atividade na turma
                    ActivityController atividade_controller = ActivityController(turma.id.collection("Activity"));
                    DocumentSnapshot snapshot_atividade = await atividade_controller.getActivity(old_titulo);
                    await atividade_controller.updateActivity(snapshot_atividade.reference, atividade);

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
                  atividade.anexo.add(link);
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
