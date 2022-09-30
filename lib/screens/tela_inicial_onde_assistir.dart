import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/screens/tela_busca_titulo.dart';
import 'package:indicacoes/screens/tela_escolha_genero.dart';

import '../config/cores.dart';
import '../widgets/botao.dart';

class TelaInicialOndeAssistir extends StatefulWidget {
  const TelaInicialOndeAssistir({Key? key}) : super(key: key);

  @override
  State<TelaInicialOndeAssistir> createState() =>
      _TelaInicialOndeAssistirState();
}

class _TelaInicialOndeAssistirState extends State<TelaInicialOndeAssistir> {
  String? tipoIndicacao;

  void _avancarPagina() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TelaBuscaTitulo(tipoIndicacao!),
    ));
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
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(44.0),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                "assets/images/Onde_assistir.svg",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(
                height: 50,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Você quer informações\nsobre o quê?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 64,
                    fontWeight: FontWeight.w600,
                    color: Cores.ROXO,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Botao(
                    "Série",
                    Icons.done_rounded,
                    () {
                      tipoIndicacao = "Série";
                      _avancarPagina();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Botao(
                    "Filme",
                    Icons.done_rounded,
                    () {
                      tipoIndicacao = "Filme";
                      _avancarPagina();
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
