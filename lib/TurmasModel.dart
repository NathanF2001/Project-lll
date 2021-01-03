import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';

class TurmasModel extends StatelessWidget {
  final info_turma;


  TurmasModel(this.info_turma);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          color: Colors_myclass.dark_color,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Icon(
                Icons.person,
                color: Colors.grey,
                size: 50,
              ),
            ),
            title: Text(
              info_turma["Nome_turma"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            subtitle: Text(
              info_turma["Nome_professor"],
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 16),
            ),
          ),
        ),
        Container(
          color: Colors.grey[200],
          height: 150,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(info_turma["Info_turma"],
              style: TextStyle(color: Colors.grey[600],),
              textAlign: TextAlign.justify,
              ),
          )
        )
      ],
    );
  }
}
