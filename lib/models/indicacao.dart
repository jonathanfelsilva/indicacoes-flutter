class Indicacao {
  String titulo;
  String descricao;
  String pathImagem;
  double nota;
  String generos;
  List<dynamic> lugaresDisponibilidade;

  Indicacao({
    required this.titulo,
    required this.descricao,
    required this.pathImagem,
    required this.nota,
    required this.generos,
    required this.lugaresDisponibilidade,
  });

  @override
  String toString() {
    return 'Indicacao{titulo: $titulo, descricao: $descricao, pathImagem: $pathImagem, nota: $nota, generos: $generos}';
  }
}
