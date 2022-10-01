import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../config/cores.dart';
import '../models/indicacao.dart';
import '../widgets/botao.dart';

import '../services/api_service.dart' as api;

class TelaIndicacao extends StatefulWidget {
  const TelaIndicacao(this.tipoIndicacao, this.genero, this.random, {Key? key})
      : super(key: key);

  final String? tipoIndicacao;
  final String? genero;
  final bool? random;

  @override
  State<TelaIndicacao> createState() => _TelaIndicacaoState();
}

class _TelaIndicacaoState extends State<TelaIndicacao> {
  void _gerarOutraRecomendacao() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>
          TelaIndicacao(widget.tipoIndicacao, widget.genero, widget.random),
    ));
  }

  Future<Indicacao> _gerarIndicacao() async {
    Indicacao indicacao = widget.random == false
        ? await api.getRecommendation(
            context, widget.tipoIndicacao, widget.genero)
        : await api.getRandomRecommendation(context);

    return indicacao;
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
      body: FutureBuilder<Indicacao>(
        future: _gerarIndicacao(),
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
                          color: const Color.fromARGB(255, 100, 100, 100),
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
                  child: Column(children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        fadeInDuration: const Duration(milliseconds: 200),
                        image: snapshot.data!.pathImagem,
                        placeholder: '/images/Transparente.png',
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.titulo,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Cores.ROXO,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(snapshot.data!.dataLancamento))
                          .toString(),
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.generos,
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          snapshot.data!.nota / 2 >= 1
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                        ),
                        Icon(
                            snapshot.data!.nota / 2 >= 2
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber),
                        Icon(
                            snapshot.data!.nota / 2 >= 3
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber),
                        Icon(
                            snapshot.data!.nota / 2 >= 4
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber),
                        Icon(
                            snapshot.data!.nota / 2 >= 5
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber)
                      ],
                    ),
                    // Text(
                    //   'Nota: ${(snapshot.data!.nota / 2).toString()}',
                    //   style: GoogleFonts.quicksand(
                    //     fontSize: 22,
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.black,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 3,
                      alignment: WrapAlignment.center,
                      children: snapshot.data!.lugaresDisponibilidade
                          .map((lugar) => Column(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      fadeInDuration:
                                          const Duration(milliseconds: 200),
                                      image:
                                          'https://image.tmdb.org/t/p/w500${lugar["logo_path"]}',
                                      placeholder: '/images/Transparente.png',
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: Wrap(children: [
                                      Center(
                                        child: Text(
                                          lugar["provider_name"],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Cores.ROXO,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * 0.8
                          : MediaQuery.of(context).size.width / 2,
                      child: Text(
                        snapshot.data!.descricao,
                        style: GoogleFonts.quicksand(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Botao(
                      "Quero outra indicação",
                      Icons.done_rounded,
                      _gerarOutraRecomendacao,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ]),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
