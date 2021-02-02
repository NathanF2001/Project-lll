class Content{
  String titulo;
  String orientacao;
  List<dynamic> anexo;
  String data;

  Content.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    titulo = json["titulo"];
    orientacao = json["orientacao"];
    anexo = json["anexo"];
    data = json["data"];
  }

  Map<String, dynamic> ToJson() => {
    "titulo": titulo,
    "orientacao": orientacao,
    "anexo": anexo,
    "data": data,
  };
}