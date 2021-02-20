import 'package:flutter/material.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';

class ListPessoa extends StatelessWidget {
  List<Aluno> alunos;
  Turma turma;

  ListPessoa(this.alunos, this.turma);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          turma.Nome,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: alunos.length,
            itemBuilder: (context,index){
            Aluno aluno = alunos[index];
              return Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    aluno.info.UrlFoto == ""
                        ? Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                          BorderRadius.all(Radius.circular(100))),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 50.0,
                      ),
                    )
                        : CircleAvatar(
                      backgroundImage:
                      NetworkImage(aluno.info.UrlFoto),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            aluno.info.nome,
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(aluno.info.email)
                        ],
                      ),
                    ),
                  ],
                ),
              );
        })
      ),
    );
  }
}
