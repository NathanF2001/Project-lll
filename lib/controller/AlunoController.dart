import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myclass/models/Activity.dart';

class AlunoController{

  addActivitytoAlunos(CollectionReference colref,String titulo){
    colref.get().then((value) => value.docs.forEach((element) {
      colref.doc(element.id).set({titulo: false},SetOptions(merge: true));
    }));
  }
}