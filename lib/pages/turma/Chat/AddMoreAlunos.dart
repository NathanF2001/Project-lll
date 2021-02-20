import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Chat.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class AddMoreAlunos extends StatefulWidget {
  List<Aluno> alunos;
  Chat chat;
  Turma turma;

  AddMoreAlunos(this.alunos,this.chat,this.turma);

  @override
  _AddMoreAlunosState createState() => _AddMoreAlunosState();
}

class _AddMoreAlunosState extends State<AddMoreAlunos> {
  final _formKey = GlobalKey<FormState>();
  List<Aluno> get alunos => widget.alunos;
  Chat get chat => widget.chat;
  Turma get turma => widget.turma;
  Aluno current_aluno;
  List<Aluno> Wrap_alunos;

  @override
  void initState() {

    super.initState();
    chat.alunos.removeWhere((element) => element.email == turma.Professor.email);

    Wrap_alunos = chat.alunos.map((e) => alunos.where((element) => (e.email == element.info.email)).first).toList();

  }


  @override
  Widget build(BuildContext context) {
    return Utils().Scaffold_myclass(title: "Alunos", body: _formUpdateChat());
  }

  _formUpdateChat() {
    return Padding(
      padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.75,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Alunos*',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))),
                        ),
                        items:
                        alunos.map<DropdownMenuItem<Aluno>>((aluno) {
                          return DropdownMenuItem<Aluno>(
                            value: aluno,
                            child: Text(aluno.info.nome),
                          );
                        }).toList(),
                        value: current_aluno,
                        onChanged: (Aluno value) {
                          current_aluno = value;
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            if (!Wrap_alunos.contains(current_aluno)){
                              Wrap_alunos.add(current_aluno);
                            }

                          });
                        },
                      ),
                    )
                  ],
                ),
                Utils.spaceMediumHeight,
                Wrap(
                  children: Wrap_alunos.map((element) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        Wrap_alunos.remove(element);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors_myclass.black,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          element.info.nome,
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
                Utils.spaceBigHeight,
                Buttons_myclass.Button1(context, text: "Atualizar Alunos chat",colorbackground: Colors_myclass.black,
                function: (){
                  Nav.pop(context,result: Wrap_alunos);
                })
              ],
            )
        )
    );
  }
}
