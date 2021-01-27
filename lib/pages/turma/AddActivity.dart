import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Utils.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final _formKey = GlobalKey<FormState>();
  List<Widget> Wrap_widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Nome da turma",
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
                  maxLength: 45
              ),
              Utils.Text_input(
                  hintmensage: "Insira a orientação da atividade",
                  labelmensage: "Orientação *",
                  key_type: TextInputType.multiline
              ),
              Utils.spaceMediumHeight,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    height: 60,
                    child: Container(
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(16))),
                          hintText: "dd/mm/aaaa",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                          labelText: "Prazo",
                          labelStyle:
                          TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    height: 60,
                    child: Container(
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(16))),
                          hintText: "horario hh:mm",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                          labelText: "Horário",
                          labelStyle:
                          TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),

                  ),
                ],
              ),
              Utils.spaceBigHeight,
              Wrap(
                children: Wrap_widgets,
                alignment: WrapAlignment.center,
              ),
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(32))),
                child: InkWell(
                  child: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  onTap: () {
                    setState(() {
                      Wrap_widgets.add(Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Content",
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.grey[100]));
                    });
                  },
                ),
              ),
              Utils.spaceBigHeight,
              Buttons_myclass.Button1(context,
                  text: "Adicionar atividade", function: () {})
            ],
          ),
        ));
  }
}
