import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/models/Pessoa.dart';

class TurmasTemplate extends StatelessWidget {
  final info_turma;

  TurmasTemplate(this.info_turma);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("Users").doc(info_turma["Professor"]).get(),
        builder: (context, snapshot){

          if (snapshot.connectionState == ConnectionState.done){
            Pessoa professor = Pessoa.fromJson(snapshot.data.data());
            return Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors_myclass.app_color,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(info_turma["UrlTurma"]),
                    ),
                    title: Text(
                      info_turma["Nome"],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    subtitle: Text(
                      professor.nome,
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors_myclass.white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16))
                    ),
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(info_turma["Descricao"],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(color: Colors.grey[600],),
                        textAlign: TextAlign.justify,
                      ),
                    )
                )
              ],
            );
          }
          return Container();
    });
  }
}