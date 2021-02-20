import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myclass/controller/StorageRepo.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/SocialEconomico.dart';

class PessoaController {
  final _user = FirebaseFirestore.instance;

  Future<List<dynamic>> addUser(email, nome, foto, id, ref_SE) async {
    /**
     * Método que adiciona usuário no Firestore
     */
    final pessoa = Pessoa(email, nome, "", "", foto, [], null, null);

    await _user.collection("Users").doc(id).set({
      "email": email,
      "nome": nome,
      "instituicao": "",
      "descricao": "",
      "UrlFoto": foto,
      "Turmas_reference": [],
      "ref_SE": ref_SE,
      "classificação": null
    });
    DocumentReference ref = _user.collection("Users").doc(id);

    return [pessoa, ref];
  }

  Future<void> updateUser(Pessoa pessoa, id) {
    /**
     * Método que atualiza informações do usuário
     */
    _user.collection("Users").doc(id).update(pessoa.ToJson());
  }

  Future<List<dynamic>> getInfo_user(fuser) async {
    /**
     * Método que retorna informações do usuário de acordo com Authetication
     */
    return await _user
        .collection("Users")
        .doc(fuser.uid)
        .get()
        .then((DocumentSnapshot documentsnapshot) async {
      if (!documentsnapshot.exists) {
        // Caso que a conta está sendo criada pelo Google sign in
        DocumentReference ref_SE = await add_SE();
        SocialEconomico SE_user = await get_SE(ref_SE);
        List<dynamic> result = await addUser(
            fuser.email, fuser.displayName, fuser.photoURL, fuser.uid, ref_SE);
        Pessoa pessoa = result[0];
        DocumentReference ref_pessoa = result[1];
        pessoa.ref_SE = SE_user;

        return [pessoa, ref_pessoa, ref_SE];
      } else {
        final pessoa = Pessoa.fromJson(documentsnapshot.data());
        SocialEconomico SE_user =
            await get_SE(documentsnapshot.data()["ref_SE"]);
        pessoa.ref_SE = SE_user;
        return [
          pessoa,
          documentsnapshot.reference,
          documentsnapshot.data()["ref_SE"]
        ];
      }
    });
  }

  Future<Pessoa> get_user(DocumentReference ref) async {
    /**
     * Método que retorna entidade Pessoa por uma referencia de usuário
     */
    return await ref.get().then((value) async {
      Pessoa user = Pessoa.fromJson(value.data());
      SocialEconomico SE_user = await get_SE(value.data()["ref_SE"]);
      user.ref_SE = SE_user;
      return user;
    });
  }

  Future<DocumentReference> add_SE() async {
    /**
     * Adiciona informações socioeconomicas
     */

    return await _user.collection("Socialeconomico").add({
      "Idade_intervalos": "",
      "Estado_civil": "",
      "Raça_cor": "",
      "Escolaridade_pai": "",
      "Escolaridade_mae": "",
      "Renda_familia": "",
      "Situacao_financeira": "",
      "Situacao_trabalho": "",
      "Bolsa_estudo": "",
      "Bolsa_academico": "",
      "Atividade_exterior": "",
      "Ingresso_cota": "",
      "Incetivou_graduacao": "",
      "Estudo_idioma": "",
      "Motivo_curso": "",
      "iscomplete": false
    });
  }

  Future<SocialEconomico> get_SE(DocumentReference ref_SE) async {
    /**
     * Método que retorna dados de uma refência de dados socioeconomicos
     */
    return await ref_SE
        .get()
        .then((value) => SocialEconomico.fromJson(value.data()));
  }

  Future<void> update_SE(json, DocumentReference ref_SE) async {
    /**
     * Atualiza informações de dados socioeconômicos
     */
    await ref_SE.update(json);
  }

  Future<void> update_classifier(ref_user, classifier) async {
    /**
     * Método que atualiza o status de classificação do ML
     */
    await ref_user.update({"classificação": classifier});
  }

  Future<DocumentReference> getref(String email) async {
    /**
     * Método que retorna referência do usuário pelo email
     */
    return await _user
        .collection("Users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) => value.docs.first.reference);
  }

  Future<String> update_UrlFoto(Pessoa pessoa) async {
    /**
     * Método que atualiza foto do usuário
     */
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    File file = File(image.path);

    String url =
        await StorageRepo().uploadFile(file, "User/${pessoa.email}.jpg");

    return url;
  }

  Future<Pessoa> update_Turmas(cod_turma, id_pessoa, Pessoa pessoa) async {
    /**
     * Método que atualiza quantidade de turmas do usuário
     */
    pessoa.add_turma(cod_turma);
    await id_pessoa.update({
      "Turmas_reference": FieldValue.arrayUnion([cod_turma])
    });
    return pessoa;
  }
}
