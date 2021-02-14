import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/ActivityAluno.dart';
import 'package:myclass/models/Alunos.dart';

class ActivityController{

  CollectionReference _content;

  ActivityController(this._content);

  add_activity(titulo,descricao,anexo,prazo_dia,prazo_hora) async{
    /**
     * Método que adiciona atividade na Turma
     */
    return await _content.add({
      "titulo": titulo,
      "orientacao": descricao,
      "anexo": anexo,
      "prazo_dia": prazo_dia,
      "prazo_hora": prazo_hora,
      "enviados": 0,
    });


  }

  add_send(ref,number) async{
    /**
     * Método que atualiza o número de alunos que mandaram a atividade
     */
    await ref.update({
      "enviados": FieldValue.increment(number)
    });
  }

  addActivitiestoAlunos(DocumentReference ref_activity,String titulo,List<Aluno> alunos){
    /**
     * Método que adiciona nova atividade a todos os alunos da turma
     */

    alunos.forEach((aluno) async{
      await addActivityAluno(ref_activity, titulo, aluno.ref_pessoa);
    });

  }

  addActivityAluno(DocumentReference refActivity,titulo,DocumentReference ref_aluno) async{
    /**
     * Método para adicionar atividade ao Aluno
     */

    await refActivity.collection("Atividade alunos").add({
      "aluno": ref_aluno,
      "links": [],
      "nota": "",
      "enviado": false,
    });
  }

  addAllActitiviesAluno(DocumentReference refAluno) async{
    /**
     * Método que adiciona as atividades existente na turma para o Aluno que entrar
     */

    List<DocumentSnapshot> atividades = await getAllActivities();
    atividades.forEach((element) {
      addActivityAluno(element.reference,element["titulo"],refAluno);});
  }
  
  Future<DocumentSnapshot> getActivity(titulo) async{
    return await _content.where("titulo",isEqualTo: titulo).get().then((value) => value.docs.first);
  }

  Future<DocumentReference> getAlunoActivity(DocumentReference ref_activity,ref_aluno) async{
    return await ref_activity.collection("Atividade alunos").where("aluno",isEqualTo: ref_aluno).get().then((value) => value.docs.first.reference);
  }
  
  updateActivity(ref_atividade,Activity atividade) async{
    await ref_atividade.update(atividade.ToJson());
  }

  Future<List<DocumentSnapshot>>getAllActivities()async{
    /**
     * Método que pega todas as atividades
     */

    return await _content.get().then((value) => value.docs);
  }

  Future<Map<String,ActivityAluno>> getAlunosActivity(ref_atividade) async {
    return await ref_atividade.collection("Atividade alunos").get().then((value){
      Map<String,ActivityAluno> atividade_aluno = {};
      value.docs.forEach((aluno_atividade) {
        Map<String,dynamic> json_ativides = aluno_atividade.data();
        atividade_aluno[json_ativides["aluno"].id] = ActivityAluno.fromJson(json_ativides);
      });
      return atividade_aluno;});
  }

  Future<List<Activity>> fromJsonList(List<DocumentSnapshot> docs) async{


    List<Future<Activity>> future_atividades = docs.map((e) async{
      Map<String,ActivityAluno> atividade_alunos = await getAlunosActivity(e.reference);
      Activity atividades = Activity.fromJson(e.data());
      atividades.atividades_alunos = atividade_alunos;

      return atividades;
    }).toList();

    List<Activity> atividades = await Future.wait(future_atividades);

    return atividades;
  }



}