class Jogo {
  final String id;
  final String nome;
  final String imagemUrl;
  final String genero;
  final String plataforma;
  final String descricao;
  double horasJogadas;
  double avaliacao;

  Jogo({
    required this.id,
    required this.nome,
    required this.imagemUrl,
    required this.genero,
    required this.plataforma,
    required this.descricao,
    required this.horasJogadas,
    required this.avaliacao,
  });
}