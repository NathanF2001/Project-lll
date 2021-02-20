import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Content.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/turma/Content/UpdateContent.dart';
import 'package:url_launcher/url_launcher.dart';


class ContentDetail extends StatefulWidget {
  Turma turma;
  Content conteudo;
  Pessoa user;

  ContentDetail(this.turma, this.conteudo,this.user);

  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  Turma get turma => widget.turma;
  Content  get conteudo => widget.conteudo;
  Pessoa get user => widget.user;

  set conteudo(new_value){
    widget.conteudo = new_value;
  }

  @override
  Widget build(BuildContext context) {
    return Utils().Scaffold_myclass(title: turma.Nome, body: _buildDetail(context));
  }

  _buildDetail(context) {
    return ListView(
      children: [
        Container(

          color: Colors_myclass.black,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(16),
          child: Text(
            conteudo.titulo,
            style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors_myclass.white),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            "Data enviada: ${conteudo.data}",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            conteudo.orientacao,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child:  Wrap(
            children: conteudo.anexo.map((element) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      text: element,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    recognizer: TapGestureRecognizer()..onTap = () async{
                        if (await canLaunch(element)){
                          await launch(element);
                        }
                    }
                  )
                )
              );
            }).toList(),
          ),
        ),
        Utils.spaceBigHeight,
        turma.Professor.email == user.email ?
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Buttons_myclass.Button1(context, text: "Atualizar Conteúdo",colorbackground: Colors_myclass.black,
              function: () async{
                final new_conteudo = await Nav.push(context,UpdateContent(turma, conteudo));
                if (new_conteudo == null){
                  return null;
                }
                conteudo = new_conteudo;
                setState(() {

                });

              }),
        ):
        Container(),
        Utils.spaceBigHeight
      ],
    );
  }
}

