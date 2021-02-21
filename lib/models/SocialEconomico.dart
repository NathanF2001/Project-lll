class SocialEconomico{
  String idade_intervalo;
  String estado_civil;
  String raca_cor;
  String escolaridade_pai ;
  String escolaridade_mae;
  String renda_familia;
  String situacao_financeira;
  String situacao_trabalho;
  String bolsa_estudo;
  String bolsa_academica;
  String atividade_exterior;
  String ingresso_cota;
  String incetivou_graduacao;
  String estudo_idioma;
  String motivo_curso;
  bool iscomplete;

  SocialEconomico(
      this.idade_intervalo,
      this.estado_civil,
      this.raca_cor,
      this.escolaridade_pai,
      this.escolaridade_mae,
      this.renda_familia,
      this.situacao_financeira,
      this.situacao_trabalho,
      this.bolsa_estudo,
      this.bolsa_academica,
      this.atividade_exterior,
      this.ingresso_cota,
      this.incetivou_graduacao,
      this.estudo_idioma,
      this.motivo_curso,
      this.iscomplete);

  SocialEconomico.fromJson(json){
    idade_intervalo = json["Idade_intervalos"];
    estado_civil = json["Estado_civil"];
    raca_cor = json["Raça_cor"];
    escolaridade_pai = json["Escolaridade_pai"] ;
    escolaridade_mae = json["Escolaridade_mae"];
    renda_familia = json["Renda_familia"];
    situacao_financeira = json["Situacao_financeira"];
    situacao_trabalho = json["Situacao_trabalho"];
    bolsa_estudo = json["Bolsa_estudo"];
    bolsa_academica = json["Bolsa_academico"];
    atividade_exterior = json["Atividade_exterior"];
    ingresso_cota = json["Ingresso_cota"];
    incetivou_graduacao = json["Incetivou_graduacao"];
    estudo_idioma = json["Estudo_idioma"];
    motivo_curso = json["Motivo_curso"];
    iscomplete = json["iscomplete"];
  }

  Map<String, dynamic> ToJson() => {
    "Idade_intervalos": idade_intervalo,
    "Estado_civil": estado_civil,
    "Raça_cor": raca_cor,
    "Escolaridade_pai": escolaridade_pai,
    "Escolaridade_mae": escolaridade_mae,
    "Renda_familia": renda_familia,
    "Situacao_financeira": situacao_financeira,
    "Situacao_trabalho": situacao_trabalho,
    "Bolsa_estudo": bolsa_estudo,
    "Bolsa_academico": bolsa_academica,
    "Atividade_exterior": atividade_exterior,
    "Ingresso_cota": ingresso_cota,
    "Incetivou_graduacao": incetivou_graduacao,
    "Estudo_idioma": estudo_idioma,
    "Motivo_curso": motivo_curso
  };


}
