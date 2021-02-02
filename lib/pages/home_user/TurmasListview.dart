import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';

import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/TurmasTemplate.dart';

class TurmasListView extends StatefulWidget {
  List<dynamic> Turmas;
  String id_user;

  TurmasListView(this.Turmas, this.id_user);

  @override
  _TurmasListViewState createState() => _TurmasListViewState();
}

class _TurmasListViewState extends State<TurmasListView> {
  List<dynamic> get Turmas => widget.Turmas;

  String get id_user => widget.id_user;

  @override
  Widget build(BuildContext context) {
    return Turmas.isEmpty
        ? Container()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Turmas")
                .where("id", whereIn: Turmas)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final turmas = snapshot.data.docs;

                if (turmas.isEmpty) {
                  return Container();
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: turmas.length,
                      itemBuilder: (context, index) {
                        final turma = turmas[index].data();
                        return Container(
                            margin: EdgeInsets.all(8),
                            decoration: (BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0, // soften the shadow
                                  spreadRadius: 1.0, //extend the shadow
                                  offset: Offset(
                                    5.0, // Move to right 10  horizontally
                                    2.0, // Move to bottom 5 Vertically
                                  ),
                                )
                              ],
                            )),
                            child: InkWell(
                              child: TurmasTemplate(turma),
                              onTap: () {
                                Turma info_turma = Turma.fromJson(turma);
                                Nav.pushname(context, "/turma-page",
                                    arguments: [id_user, info_turma]);
                              },
                            ));
                      });
                }
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            });
  }
}
