import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Activity.dart';

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

  add_send(ref,number) async{
    /**
     * Método que atualiza o número de alunos que mandaram a atividade
     */
    await ref.update({
      "enviados": FieldValue.increment(number)
    });
  }

  addActivitiestoAlunos(CollectionReference colref,String titulo){
    /**
     * Método que adiciona nova atividade a todos os alunos da turma
     */
    colref.get().then((value) => value.docs.forEach((element) {
      addActivityAluno(element.reference, titulo);
    }));
  }

  addActivityAluno(DocumentReference refAluno,titulo) async{
    /**
     * Método para adicionar atividade ao Aluno
     */

    refAluno.set({"${titulo}_titulo": titulo,"${titulo}_links": [],"${titulo}_nota": "","${titulo}_enviado": false},SetOptions(merge: true));
  }

  addAllActitiviesAluno( DocumentReference refAluno) async{
    /**
     * Método que adiciona as atividades existente na turma para o Aluno que entrar
     */

    List<dynamic> atividades = await getAllActivities();
    atividades.forEach((element) {
      addActivityAluno(refAluno,element["titulo"]);});
  }
  
  Future<DocumentSnapshot> getActivity(titulo) async{
    return await _content.where("titulo",isEqualTo: titulo).get().then((value) => value.docs.first);
  }
  
  updateActivity(ref_atividade,Activity atividade) async{
    await ref_atividade.update(atividade.ToJson());
  }

  getAllActivities()async{
    /**
     * Método que pega todas as atividades
     */

    return _content.get().then((value) => value.docs);
  }

  List<Activity> fromJsonList(List<DocumentSnapshot> docs){
    List<Activity> atividades = docs.map((e) => Activity.fromJson(e.data())).toList();
    return atividades;
  }



}