import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';

class MensagePage extends StatefulWidget {

  @override
  _MensagePageState createState() => _MensagePageState();
}

class _MensagePageState extends State<MensagePage> {
  List<Map<String,dynamic>> MensageLog = [
    {"type":"SendMensage"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Nome da turma",
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
          child: Container(
            height: MediaQuery.of(context).size.height*0.125,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            color: Colors_myclass.main_color,
            child: Text("Nome do bate-papo",style: TextStyle(color: Colors.white,fontSize: 28),),
          ),
          preferredSize: Size(1, 80),
        ),
      ),
      body: _Mensage(),
    );
  }

  _Mensage() {

    return Container(
      child: ListView.builder(
        itemCount: MensageLog.length,
          reverse: true,
          itemBuilder: (context,index){
        return index == (MensageLog.length - 1) ?
            Container(
              height: MediaQuery.of(context).size.height*0.125,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left:16),
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        hintText: "Enviar"
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.attach_file), onPressed: (){}),
                  IconButton(icon: Icon(Icons.send_sharp), onPressed: (){})
                ],
              ),
            )
          :
        Container();
      }),
    );
  }
}