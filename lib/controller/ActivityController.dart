import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityController{

  CollectionReference _content;

  ActivityController(this._content);

  add_activity(titulo,descricao,anexo,prazo_dia,prazo_hora) async{
    /**
     * Método que adiciona atividade na Turma
     */
    await _content.add({
      "titulo": titulo,
      "orientacao": descricao,
      "anexo": anexo,
      "prazo_dia": prazo_dia,
      "prazo_hora": prazo_hora,
      "enviados": 0,
    });

    return true;
  }

  add_send(ref,number){
    /**
     * Método que atualiza o número de alunos que mandaram a atividade
     */
    ref.update({
      "enviados": FieldValue.increment(number)
    });
  }

  addActivitiestoAlunos(CollectionReference colref,String titulo){
    /**
     * Método que adiciona nova atividade a todos os alunos da turma
     */
    colref.get().then((value) => value.docs.forEach((element) {
      addActivityAluno(colref.doc(element.id), titulo);
    }));
  }

  addActivityAluno(DocumentReference refAluno,titulo){
    /**
     * Método para adicionar atividade ao Aluno
     */
    refAluno.set({titulo: false,"${titulo}_links": [],"${titulo}_nota": ""},SetOptions(merge: true));
  }

  addAllActitiviesAluno( DocumentReference refAluno) async{
    /**
     * Método que adiciona as atividades existente na turma para o Aluno que entrar
     */

    List<dynamic> atividades = await getAllActivities();
    atividades.forEach((element) {
      addActivityAluno(refAluno,element["titulo"]);});
  }

  getAllActivities()async{
    /**
     * Método que pega todas as atividades
     */

    return _content.get().then((value) => value.docs);
  }


}