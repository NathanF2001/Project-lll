class ActivityAluno{
  List<dynamic> links;
  String nota;
  bool send;

  ActivityAluno.fromJson(Map<String,dynamic> json,titulo){
    if (json == null) return;

    links = json["${titulo}_links"];
    nota = json["${titulo}_nota"];
    send = json["${titulo}_enviado"];
  }

  Map<String, dynamic> ToJson(titulo) => {
    "${titulo}_links": links,
    "${titulo}_nota": nota,
    "${titulo}_send": send,
  };

}