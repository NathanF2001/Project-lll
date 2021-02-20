import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/ActivityAluno.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';

class ProfessorNotasAlunos extends StatelessWidget {
  Turma turma;
  List<Activity> atividades;
  List<Aluno> alunos;


  ProfessorNotasAlunos(this.turma, this.atividades, this.alunos);

  @override
  Widget build(BuildContext context) {

    return Utils().Scaffold_myclass(title: turma.Nome, body: _buildNotasAluno(context));
  }

  _buildNotasAluno(BuildContext context) {
    return ListView.builder(
        itemCount: alunos.length,
        itemBuilder: (context, index) {
          Aluno aluno = alunos[index];
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors_myclass.black,
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
                              backgroundImage: NetworkImage(aluno.info.UrlFoto),
                            ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            aluno.info.nome,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                                color: Colors_myclass.white),
                          ),
                          Text(
                            aluno.info.email,
                            style: TextStyle(color: Colors_myclass.white),
                          ),
                          Utils.spaceSmallHeight,
                          Text(
                            "Destaques: ${aluno.destaques}",
                            style: TextStyle(
                              color: Colors_myclass.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                    child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text('Atividade',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                        label: Text('Nota',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold))),
                  ],
                  rows: atividades
                      .map((atividade) {
                    ActivityAluno atividade_aluno = atividade.atividades_alunos[aluno.ref_pessoa.id];
                    return DataRow(
                        cells: [
                          DataCell(Text(atividade.titulo)),
                          DataCell(Text(atividade_aluno.nota == "" ? "Sem nota" : atividade_aluno.nota,))
                        ]
                    );
                  })
                      .toList(),
                ))
              ],
            ),
          );
        });
  }
}
