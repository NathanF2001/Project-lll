import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/models/Pessoa.dart';

import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/TurmasTemplate.dart';

class TurmasListView extends StatefulWidget {
  final Turmas;

  TurmasListView(this.Turmas);

  @override
  _TurmasListViewState createState() => _TurmasListViewState();
}

class _TurmasListViewState extends State<TurmasListView> {
  get Turmas => widget.Turmas;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Turmas")
            .where("id", whereIn: Turmas)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                          child: TurmasTemplate(turma),
                          onTap: () => Nav.pushname(context, "/turma-page"),
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
