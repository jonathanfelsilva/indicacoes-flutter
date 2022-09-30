import 'package:flutter/material.dart';
import 'package:indicacoes/screens/tela_visualizacao_filme_serie.dart';

import '../../models/indicacao.dart';

class TileTopIndicacao extends StatefulWidget {
  final Indicacao indicacao;

  const TileTopIndicacao(this.indicacao, {super.key});

  @override
  State<TileTopIndicacao> createState() => _TileTopIndicacaoState();
}

class _TileTopIndicacaoState extends State<TileTopIndicacao> {
  void _abrirPaginaIndicacao() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TelaVisualizacaoFilmeSerie(widget.indicacao),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: _abrirPaginaIndicacao,
            child: SizedBox(
              width: 150,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  fadeInDuration: const Duration(milliseconds: 200),
                  image: widget.indicacao.pathImagem,
                  placeholder: '/images/Transparente.png',
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
