class Indicacao {
  String titulo;
  String descricao;
  String pathImagem;
  double nota;

  Indicacao(
      {required this.titulo,
      required this.descricao,
      required this.pathImagem,
      required this.nota});

  @override
  String toString() {
    return 'Indicacao{titulo: $titulo, descricao: $descricao, pathImagem: $pathImagem, nota: $nota}';
  }
}
