import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';

class TurmasTemplate extends StatelessWidget {
  final info_turma;

  TurmasTemplate(this.info_turma);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,

          decoration: BoxDecoration(
              color: Colors_myclass.dark_color,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
          ),
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
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
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16))
            ),
          height: 150,
            width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(info_turma["Info_turma"],
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
}
