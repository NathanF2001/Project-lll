class Turma{
  String Nome;
  String Descricao;
  String Modalidade;
  String CodTurma;
  String UrlTurma;
  String Professor;
  String id;
  List<dynamic> Alunos;

  Turma(this.Nome, this.Descricao, this.Modalidade, this.CodTurma,
      this.UrlTurma, this.Professor, this.Alunos,this.id);

  Turma.fromJson(Map<String,dynamic> json){
    if (json == null) return;

    Nome = json["Nome"];
    Descricao = json["Descricao"];
    Modalidade = json["Modalidade"];
    CodTurma = json["CodTurma"];
    UrlTurma = json["UrlTurma"];
    Professor = json["Professor"];
    Alunos = json["Alunos"];
    id = json["id"];
  }

  Map<String, dynamic> ToJson() => {
  "Nome": Nome,
  "Descricao" : Descricao,
  "Modalidade": Modalidade,
  "CodTurma": CodTurma,
  "UrlTurma": UrlTurma,
  "Professor": Professor,
  "Alunos": Alunos,
    "id": id
  };


}