import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';

class TurmaController {
  final _user = FirebaseFirestore.instance;

  create_turma(json,Pessoa pessoa,id_professor) async {

    json["UrlTurma"] = pessoa.UrlFoto;
    json["Professor"] = id_professor;

    List<dynamic> turmas = pessoa.Turmas_reference;

    DocumentReference ref = await _user.collection("Turmas").add({});
    pessoa.add_turma(ref);

    json["id"] = ref;

    _user.collection("Turmas").doc(ref.id).set(json);

    _user
        .collection("Users")
        .doc(id_professor)
        .update({"Turmas_reference": pessoa.Turmas_reference});

    return pessoa;
  }


}
