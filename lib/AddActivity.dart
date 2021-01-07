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
                  hintmensage: "Adicione um título",
                  labelmensage: "Título *",
                  maxLength: 45),
              Utils.Text_input(
                  hintmensage: "Adicione um assunto",
                  labelmensage: "Orientação *",
                  key_type: TextInputType.multiline),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          hintText: "dd/mm/aaaa",
                          hintStyle: TextStyle(
                            fontSize: 24,
                          ),
                          labelText: "Prazo",
                          labelStyle:
                              TextStyle(fontSize: 24, color: Colors.black)),
                    ),
                  ),
                  Container(
                    width: 175,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          hintText: "horário hh:mm",
                          hintStyle: TextStyle(
                            fontSize: 24,
                          ),
                          ),
                    ),
                  )
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
                    borderRadius: BorderRadius.all(Radius.circular(16))),
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
                  text: "Adicionar conteúdo", function: () {})
            ],
          ),
        ));
  }
}
