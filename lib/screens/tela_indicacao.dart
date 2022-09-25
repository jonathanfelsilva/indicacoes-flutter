import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/cores.dart';
import '../models/indicacao.dart';
import '../widgets/botao.dart';

import '../services/api_service.dart' as api;

class TelaIndicacao extends StatefulWidget {
  const TelaIndicacao(this.tipoIndicacao, this.genero, {Key? key})
      : super(key: key);

  final String? tipoIndicacao;
  final String? genero;

  @override
  State<TelaIndicacao> createState() => _TelaIndicacaoState();
}

class _TelaIndicacaoState extends State<TelaIndicacao> {
  void _gerarOutraRecomendacao() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => TelaIndicacao(widget.tipoIndicacao, widget.genero),
    ));
  }

  Future<Indicacao> _gerarIndicacao() async {
    return await api.getRecommendation(
        context, widget.tipoIndicacao, widget.genero);
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
            return const Center(
              child: CircularProgressIndicator(),
            );

            //Column(
            //   children: [
            //     Center(
            //       child: SingleChildScrollView(
            //         physics: const BouncingScrollPhysics(),
            //         child: Padding(
            //           padding: const EdgeInsets.all(44.0),
            //           child: Column(children: <Widget>[
            //             const SizedBox(
            //               height: 50,
            //             ),
            //             SvgPicture.asset(
            //               "assets/images/Tela_3.svg",
            //               height: MediaQuery.of(context).size.height * 0.3,
            //             ),
            //             const SizedBox(
            //               height: 50,
            //             ),
            //             FittedBox(
            //               fit: BoxFit.scaleDown,
            //               child: Text(
            //                 "Buscando...",
            //                 textAlign: TextAlign.center,
            //                 style: GoogleFonts.quicksand(
            //                   fontSize: 64,
            //                   fontWeight: FontWeight.w600,
            //                   color: Cores.ROXO,
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             FittedBox(
            //               fit: BoxFit.scaleDown,
            //               child: Text(
            //                 "Já pode ir preparando\na pipoca!",
            //                 style: GoogleFonts.quicksand(
            //                   fontSize: 36,
            //                   fontWeight: FontWeight.w400,
            //                   color: Colors.grey,
            //                 ),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ),
            //             const SizedBox(
            //               width: 50,
            //             ),
            //           ]),
            //         ),
            //       ),
            //     ),
            //     CircularProgressIndicator(),
            //   ],
            //);
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
                      child: Image.network(
                        snapshot.data!.pathImagem,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Avaliação: ${snapshot.data!.nota.toString()}',
                      style: GoogleFonts.quicksand(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.titulo,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: 64,
                        fontWeight: FontWeight.w600,
                        color: Cores.ROXO,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * 0.8
                          : MediaQuery.of(context).size.width / 2,
                      child: Text(
                        snapshot.data!.descricao,
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
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
