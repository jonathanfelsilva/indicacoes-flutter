class Indicacao {
  int id;
  String titulo;
  String descricao;
  String pathImagem;
  double nota;
  String generos;
  String tipo;
  List<dynamic> lugaresDisponibilidade;

  Indicacao({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.pathImagem,
    required this.nota,
    required this.generos,
    required this.tipo,
    required this.lugaresDisponibilidade,
  });

  @override
  String toString() {
    return 'Indicacao{id: $id, titulo: $titulo, descricao: $descricao, pathImagem: $pathImagem, nota: $nota, generos: $generos, tipo: $tipo}';
  }
}
