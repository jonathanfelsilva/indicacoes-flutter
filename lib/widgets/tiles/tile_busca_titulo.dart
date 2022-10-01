import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/cores.dart';
import '../../models/indicacao.dart';
import '../../screens/tela_visualizacao_filme_serie.dart';

class TileBuscaTitulo extends StatefulWidget {
  final Indicacao indicacao;

  const TileBuscaTitulo(this.indicacao, {super.key});

  @override
  State<TileBuscaTitulo> createState() => _TileBuscaTituloState();
}

class _TileBuscaTituloState extends State<TileBuscaTitulo> {
  void _abrirPaginaFilmeSerie() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TelaVisualizacaoFilmeSerie(widget.indicacao),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: _abrirPaginaFilmeSerie,
            child: SizedBox(
              width: 250,
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  fadeInDuration: const Duration(milliseconds: 500),
                  image: widget.indicacao.pathImagem,
                  placeholder: '/images/Transparente.png',
                  imageErrorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) =>
                      const Icon(Icons.question_mark_rounded),
                  height: 350,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
