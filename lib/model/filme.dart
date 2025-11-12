class Filme {
  int? id;
  String imagem;
  String titulo;
  String genero;
  String faixaEtaria;
  String duracao;
  double pontuacao;
  String descricao;
  String ano;

  Filme({
    this.id,
    required this.imagem,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
    required this.descricao,
    required this.ano,
  });

  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      imagem: json['imagem'],
      titulo: json['titulo'],
      genero: json['genero'],
      faixaEtaria: json['faixaEtaria'] ?? json['faixa_etaria'],
      duracao: json['duracao'],
      pontuacao: (json['pontuacao'] as num).toDouble(),
      descricao: json['descricao'],
      ano: json['ano'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(),
      'imagem': imagem,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
    };
  }
}
