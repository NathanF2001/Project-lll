import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';

class ContentPage extends StatefulWidget {
  bool IsProfessor;

  ContentPage(this.IsProfessor);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  bool get IsProfessor {
    return widget.IsProfessor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _addContent(),
          _ContentListview()
        ],
      ),
    );
  }

  _addContent() {
    if (IsProfessor) {
      return Container(
        padding: EdgeInsets.all(8),
        color: Colors_myclass.main_color,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          onPressed: () => Nav.pushname(context, "/add-content"),
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
              "Adicionar um conteúdo",
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

  _ContentListview() {
    List<Map<String,String>>items = _getAllContents();
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
                          decoration: BoxDecoration(
                            color: Color(0xFFEFF2F7),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.person,color: Color(0xFFC0CCDA),size: 40,),
                        ),
                        Text(info_content["Nome_professor"],style: TextStyle(color: Colors.white),),
                        Text(info_content["date"],style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFEFF2F7),
                    padding: EdgeInsets.all(16),
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(info_content["Title"],style: Theme.of(context).textTheme.headline6,),
                        Utils.spaceBigHeight,
                        Text(info_content["descriçao"],style: Theme.of(context).textTheme.bodyText2,)
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  _getAllContents() {
    return [
      {
        "Nome_professor": "Nome do professor",
        "Title": "Título do conteúdo",
        "descriçao": "Orientação e descrição do conteúdo colocado",
        "date": "dd/mm/aaaa"
      },
      {
        "Nome_professor": "Nome do professor",
        "Title": "Título do conteúdo",
        "descriçao": "Orientação e descrição do conteúdo colocado",
        "date": "dd/mm/aaaa"
      },
      {
        "Nome_professor": "Nome do professor",
        "Title": "Título do conteúdo",
        "descriçao": "Orientação e descrição do conteúdo colocado",
        "date": "dd/mm/aaaa"
      },

    ];
  }
}
