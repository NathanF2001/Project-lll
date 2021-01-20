import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/nav.dart';

class MensagePage extends StatefulWidget {
  @override
  _MensagePageState createState() => _MensagePageState();
}

class _MensagePageState extends State<MensagePage> {
  List<Map<String, dynamic>> MensageLog = [
    {
      "mensage": "Olá tudo bom como você estão ?",
      "id_user": 1,
      "sending": ["01-01-21", "21:20"]
    },
    {
      "mensage": "Estou bem e vocês?",
      "id_user": 2,
      "sending": ["01-01-21", "21:21"]
    },
    {
      "mensage": "Por enquanto está tudo tranquilo",
      "id_user": 3,
      "sending": ["01-01-21", "21:22"]
    },
    {
      "mensage": "Vocês estudaram o assunto que o professor mandou?",
      "id_user": 1,
      "sending": ["01-01-21", "21:23"]
    },
    {
      "mensage": "Ainda falta mais um tópico mas creio que já possa discuti",
      "id_user": 2,
      "sending": ["01-01-21", "21:24"]
    },
    {
      "mensage": "Ok, podemos fazer alguma chamada",
      "id_user": 1,
      "sending": ["01-01-21", "21:25"]
    },
    {
      "mensage": "Só mandar o link",
      "id_user": 3,
      "sending": ["01-01-21", "21:26"]
    },
    {
      "mensage": "www.linkdachamada.com.br",
      "id_user": 1,
      "sending": ["01-01-21", "21:27"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Nome do chat",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _Mensage(),
    );
  }

  _Mensage() {
    final user_id = Nav.getRouteArgs(context);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ListView.builder(
              itemCount: MensageLog.length,
              reverse: false,
              itemBuilder: (context, index) {
                final mensage = MensageLog[index];
                return (user_id == mensage["id_user"])
                    ? Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 8, bottom: 8, left: 80),
                        padding: EdgeInsets.only(right: 16,bottom: 16,left: 8),
                        decoration: BoxDecoration(
                          color: Color(0x9900BD4F),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(mensage["sending"][1]),
                            Text(mensage["mensage"])
                          ],
                        ))
                    : Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 8, bottom: 8, right: 80),
                        padding: EdgeInsets.only(left: 8,bottom: 16,right: 8),
                        decoration: BoxDecoration(
                          color: Color(0x4D00BD4F),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mensage["sending"][1],
                            ),
                            Text(mensage["mensage"])
                          ],
                        ));
              }),
        ),
        Container(
          height: 75,
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        hintText: "Enviar"),
                  ),
                ),
              ),
              Expanded(
                child:
                    IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
              ),
              Expanded(
                  child: IconButton(
                      icon: Icon(Icons.send_sharp), onPressed: () {}))
            ],
          ),
        )
      ],
    );
  }
}
