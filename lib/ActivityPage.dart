import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';

class ActivityPage extends StatefulWidget {
  bool IsProfessor;

  ActivityPage(this.IsProfessor);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool get IsProfessor => widget.IsProfessor;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _addActivity(),
          _ActivityListview()
        ],
      ),
    );;
  }

  _addActivity() {
    if (IsProfessor) {
      return Container(
        padding: EdgeInsets.all(8),
        color: Colors_myclass.main_color,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          onPressed: () => Nav.pushname(context, "/add-activity"),
          textColor: Colors.grey,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
              side: BorderSide(color: Colors.white)
          ),
          child: Container(
            width: 250,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              "Adicionar uma atividade",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _ActivityListview() {
    List<Map<String,String>>items =  _getAllActivities();
    return Container(
      height: IsProfessor ? MediaQuery.of(context).size.height - 200 : MediaQuery.of(context).size.height - 150,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            Map<String,String> info_content = items[index];
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    color: Color(0xFFC0CCDA),
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 200,
                          child: Text(info_content["Title"],
                            maxLines: null,softWrap: true,
                            style: TextStyle(color: Colors.white),)
                          ,
                        ),
                        Text("Prazo: ${info_content["date"]}",style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFEFF2F7),
                    padding: EdgeInsets.all(16),
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(info_content["descriçao"],style: Theme.of(context).textTheme.bodyText2,),
                        Spacer(),
                        FlatButton(onPressed: (){}, child: Text("Ver mais >>",style: TextStyle(color: Colors.black),textAlign: TextAlign.right,))
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  _getAllActivities() {
    return [
      {
        "Nome_professor": "Nome do professor",
        "Title": "Título da atividade",
        "descriçao": "Orientação e descrição da atividade colocada",
        "date": "dd/mm/aaaa"
      },
      {
        "Nome_professor": "Nome do professor",
        "Title": "Título da atividade",
        "descriçao": "Orientação e descrição da atividade colocada",
        "date": "dd/mm/aaaa"
      },
      {
        "Nome_professor": "Nome do professor",
        "Title": "Título da atividade",
        "descriçao": "Orientação e descrição da atividade colocada",
        "date": "dd/mm/aaaa"
      },

    ];
  }
}
