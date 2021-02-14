import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:myclass/models/Pessoa.dart';

class StorageRepo {

  Future<String> uploadFile(File file,diretory) async{
    print(file.path);

    try{
      final uploadTask = await FirebaseStorage.instance.ref().child(diretory).putFile(file);
      String url = await uploadTask.ref.getDownloadURL();
      return url;
    } on FirebaseException catch(e){
      print(e);
    }
  }
}