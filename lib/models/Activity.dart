class Activity{
  String titulo;
  String orientacao;
  List<dynamic> anexo;
  String prazo_dia;
  String prazo_hora;
  int enviados;

  Activity.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    titulo = json["titulo"];
    orientacao = json["orientacao"];
    anexo = json["anexo"];
    prazo_dia = json["prazo_dia"];
    prazo_hora = json["prazo_hora"];
    enviados = json["enviados"];
  }

  Map<String, dynamic> ToJson() => {
    "titulo": titulo,
    "orientacao": orientacao,
    "anexo": anexo,
    "prazo_dia": prazo_dia,
    "prazo_hora": prazo_hora,
    "enviados": enviados,
  };
}