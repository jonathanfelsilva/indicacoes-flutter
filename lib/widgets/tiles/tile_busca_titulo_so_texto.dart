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
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Cores.AZUL,
                width: 2,
              )),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: _abrirPaginaFilmeSerie,
            child: ListTile(
              title: Text(
                widget.indicacao.titulo,
                style: GoogleFonts.quicksand(
                  fontSize: MediaQuery.of(context).size.width < 600 ? 16 : 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
