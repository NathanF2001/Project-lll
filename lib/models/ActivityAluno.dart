class ActivityAluno{
  List<dynamic> links;
  String nota;
  bool send;

  ActivityAluno.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    links = json["links"];
    nota = json["nota"];
    send = json["enviado"];
  }

  Map<String, dynamic> ToJson(titulo) => {
    "links": links,
    "nota": nota,
    "send": send,
  };

}