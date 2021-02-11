import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/ActivityAluno.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class DetailActivityPageAluno extends StatefulWidget {
  Turma turma;
  Activity atividade;
  Aluno aluno;


  DetailActivityPageAluno(
      this.turma, this.atividade, this.aluno);

  @override
  _DetailActivityAlunoPageState createState() =>
      _DetailActivityAlunoPageState();
}

class _DetailActivityAlunoPageState extends State<DetailActivityPageAluno> {
  Turma get turma => widget.turma;

  Activity get atividade => widget.atividade;

  Aluno get aluno => widget.aluno;

  bool send;
  List<dynamic> links;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ActivityAluno atividade_aluno = aluno.atividades[atividade.titulo];
    send = atividade_aluno.send;
    links = atividade_aluno.links;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          atividade.titulo,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildActivityInfo(context),
    );
  }

  _buildActivityInfo(context) {
    return _WidgetDetail();
  }

  _WidgetDetail() {
    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Prazo: ${atividade.prazo_dia}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                atividade.prazo_hora,
                style: TextStyle(color: Colors.grey[600]),
              )
            ],
          ),
          Utils.spaceSmallHeight,
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              send ? "Status: Enviado" : "Status: Pendente",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Utils.spaceBigHeight,
          Text(
            atividade.orientacao,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.grey[800], fontSize: 24),
          ),
          Utils.spaceMediumHeight,
          Wrap(
            children: atividade.anexo.map((e) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                alignment: Alignment.center,
                child: Text(e,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              );
            }).toList(),
          ),
          Utils.spaceMediumHeight,
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
          Utils.spaceMediumHeight,
          Column(
            children: [
              Buttons_myclass.Button1(context,
                  text: "Adicionar resposta",
                  function: () => _showAlertDialog(),
                  colorbackground: Colors_myclass.black),
              Utils.spaceSmallHeight,
              Buttons_myclass.Button1(context,
                  colorbackground: Colors_myclass.black,
                  text: send ? "Cancelar envio" : "Enviar", function: () async{

                ActivityController controller =
                    ActivityController(turma.id.collection("Activity"));

                DocumentReference ref_atividade = await turma.id.collection("Activity")
                    .where("titulo",isEqualTo: atividade.titulo).get().then((value) => value.docs.first.reference);

                if (!send) {
                  controller.add_send(ref_atividade, 1);
                  // Mandar as informações
                  print(aluno.ref_pessoa);
                  AlunoController()
                      .send(aluno.ref_pessoa,turma.id, atividade.titulo, !send, links);
                } else {
                  controller.add_send(ref_atividade, -1);
                }
                setState(() {
                  send = !send;
                });
              })
            ],
          )
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
