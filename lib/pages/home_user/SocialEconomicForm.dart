import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/SECategories.dart';

class SocialEconomicForm extends StatefulWidget {
  Pessoa user;
  DocumentReference ref_SE;

  SocialEconomicForm(this.user,this.ref_SE);

  @override
  _SocialEconomicFormState createState() => _SocialEconomicFormState();
}

class _SocialEconomicFormState extends State<SocialEconomicForm> {
  final _formKey = GlobalKey<FormState>();
  Pessoa get user => widget.user;
  DocumentReference get ref_SE => widget.ref_SE;
  Map<String,dynamic> json_SE;

  bool iscomplete = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário SocioEconomico"),
      ),
      resizeToAvoidBottomInset: false,
      body: _buildFormSE(),
      backgroundColor: Colors_myclass.white,
    );
  }

  _buildFormSE() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Idade Intervalos",
                  SECategories.Idade_intervalos, user.ref_SE.idade_intervalo, (value) {
                    print("Piu");
                    user.ref_SE.idade_intervalo = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Estado civil",
                  SECategories.Estado_civil, user.ref_SE.estado_civil, (value) {
                    user.ref_SE.estado_civil = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Raça/cor",
                  SECategories.Raca_cor, user.ref_SE.raca_cor, (value) {
                    user.ref_SE.raca_cor = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Escolaridade do pai",
                  SECategories.Escolaridade_pai, user.ref_SE.escolaridade_pai, (value) {
                    user.ref_SE.escolaridade_pai = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Escolaridade da mãe",
                  SECategories.Escolaridade_mae, user.ref_SE.escolaridade_mae, (value) {
                    user.ref_SE.escolaridade_mae = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Renda da família",
                  SECategories.Renda_familia, user.ref_SE.renda_familia, (value) {
                    user.ref_SE.renda_familia = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Situação financeira",
                  SECategories.Situacao_financeira, user.ref_SE.situacao_financeira, (value) {
                    user.ref_SE.situacao_financeira = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Situação de trabalho",
                  SECategories.Situacao_trabalho, user.ref_SE.situacao_trabalho, (value) {
                    user.ref_SE.situacao_trabalho = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Bolsa de Estudo",
                  SECategories.Bolsa_estudo, user.ref_SE.bolsa_estudo, (value) {
                    user.ref_SE.bolsa_estudo = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Bolsa de Acadêmica",
                  SECategories.Bolsa_academica, user.ref_SE.bolsa_academica, (value) {
                    user.ref_SE.bolsa_academica = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Atividade no Exterior",
                  SECategories.Atividade_exterior, user.ref_SE.atividade_exterior, (value) {
                    user.ref_SE.atividade_exterior = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Ingresso por cota",
                  SECategories.Ingresso_cota, user.ref_SE.ingresso_cota, (value) {
                    user.ref_SE.ingresso_cota = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Incentivou Graduação",
                  SECategories.Incetivou_graduacao, user.ref_SE.incetivou_graduacao, (value) {
                    user.ref_SE.incetivou_graduacao = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Estudar idioma estrangeiro",
                  SECategories.Estudo_idioma, user.ref_SE.estudo_idioma, (value) {
                    user.ref_SE.estudo_idioma = value;
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: _inputDropdown("Motivo ter entrado curso",
                  SECategories.Motivo_curso, user.ref_SE.motivo_curso, (value) {
                    user.ref_SE.motivo_curso = value;
                  }),
            ),
            Utils.spaceBigHeight,
            Padding(
              padding: EdgeInsets.all(16),
              child: Buttons_myclass.Button1(context, text: "Atualizar dados", colorbackground: Colors_myclass.black,
                  function: () async{
                    _formKey.currentState.save();
                    _formKey.currentState.validate();

                    json_SE = user.ref_SE.ToJson();
                    json_SE["iscomplete"] = iscomplete;
                    user.ref_SE.iscomplete = iscomplete;

                    await PessoaController().update_SE(json_SE, ref_SE);
                    _showAlertDialog("Dados atualizados", iscomplete ? "Status: Perfil completo" : "Status: Perfil incompleto");

                  }),
            ),
            Utils.spaceBigHeight
          ],
        ),
      )
    );
  }

  _inputDropdown(String text, list_values, initial_value, saved) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(fontSize: 24),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        items: list_values.map<DropdownMenuItem<String>>((modalidade) {
          return DropdownMenuItem<String>(
              value: modalidade,
              child: Container(
                width: MediaQuery.of(context).size.width*0.75,
                child:Text(modalidade,maxLines: null,),
              )
          );
        }).toList(),
        validator: (value){
          if (value == ""){
            iscomplete = false;
          }
          return null;
        },
        value: initial_value,
        onChanged: (value) {},
        onSaved: saved);
  }

  _showAlertDialog(Title_mensage, content_mensage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Title_mensage,
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            content_mensage,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            FlatButton(
              onPressed: () => Nav..pop(context)..pop(context,result: user),
              child: Text("OK"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
