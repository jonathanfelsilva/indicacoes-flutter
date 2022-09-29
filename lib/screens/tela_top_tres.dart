import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/widgets/tiles/tile_top_indicacao.dart';

import '../config/cores.dart';
import '../models/indicacao.dart';

import '../services/api_service.dart' as api;

class TelaTopTres extends StatefulWidget {
  const TelaTopTres({Key? key}) : super(key: key);

  @override
  State<TelaTopTres> createState() => _TelaTopTresState();
}

class _TelaTopTresState extends State<TelaTopTres> {
  Future<Map<String, List<Indicacao>>> _gerarListaTopIndicacoes() async {
    List<Indicacao> topFilmes = await api.getTopThree(context, 'Filme');
    List<Indicacao> topSeries = await api.getTopThree(context, 'Série');
    Map<String, List<Indicacao>> listaCompleta = Map<String, List<Indicacao>>();
    listaCompleta["filmes"] = topFilmes;
    listaCompleta["series"] = topSeries;
    return listaCompleta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Cores.AZUL,
          size: 40,
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, List<Indicacao>>>(
        future: _gerarListaTopIndicacoes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/Tela_3.svg",
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Buscando...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                          color: Cores.ROXO,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Já pode ir pegando a pipoca!",
                        style: GoogleFonts.quicksand(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 100, 100, 100),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(44.0),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Top 3 de hoje",
                          style: GoogleFonts.quicksand(
                            fontSize: 80,
                            fontWeight: FontWeight.w600,
                            color: Cores.AZUL,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        indent: MediaQuery.of(context).size.width * 0.15,
                        endIndent: MediaQuery.of(context).size.width * 0.15,
                        thickness: 4,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Filmes",
                          style: GoogleFonts.quicksand(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Cores.ROXO,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 250,
                        width: 600,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!["filmes"]!
                              .map(
                                (indicacao) => TileTopIndicacao(indicacao),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Séries",
                          style: GoogleFonts.quicksand(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Cores.ROXO,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 250,
                        width: 600,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!["series"]!
                              .map(
                                (indicacao) => TileTopIndicacao(indicacao),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
