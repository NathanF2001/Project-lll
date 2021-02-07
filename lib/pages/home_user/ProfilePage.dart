import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Pessoa.dart';

class ProfilePage extends StatelessWidget {
  Pessoa pessoa;

  ProfilePage(this.pessoa);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),

        title: Text(
          "Perfil",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utils.spaceBigHeight,
                Container(
                  alignment: Alignment.center,
                  child: pessoa.UrlFoto == ""
                      ? Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 150,
                    ),
                  )
                      : CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage(pessoa.UrlFoto),
                  ),
                ),
                Utils.spaceMediumHeight,
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width*0.75,
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(32),bottomRight: Radius.circular(32))

                  ),
                  child: Text("Nome",
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors_myclass.white),),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    pessoa.nome,
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width*0.75,
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(32),bottomRight: Radius.circular(32))

                  ),
                  child: Text("Email",
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors_myclass.white),),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    pessoa.email,
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width*0.75,
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(32),bottomRight: Radius.circular(32))

                  ),
                  child: Text("Descrição",
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors_myclass.white),),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    pessoa.descricao,
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
}
