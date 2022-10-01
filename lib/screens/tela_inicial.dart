import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/screens/tela_escolha_tipo_indicacao.dart';
import 'package:indicacoes/screens/tela_top_tres.dart';

import '../config/cores.dart';
import '../widgets/botao.dart';
import 'tela_inicial_onde_assistir.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  TextEditingController telefoneController = TextEditingController();

  void _avancarPagina() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TelaEscolhaTipoIndicacao(),
    ));
  }

  void _avancarParaTopTres() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TelaTopTres(),
    ));
  }

  void _avancarParaOndeAssistir() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TelaInicialOndeAssistir(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Olá! Que bom te ver\npor aqui.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontSize: 64,
                    fontWeight: FontWeight.w600,
                    color: Cores.ROXO,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Do que você precisa hoje?",
                  style: GoogleFonts.quicksand(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Cores.CINZA,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Botao(
                    "Indicação",
                    Icons.done_rounded,
                    _avancarPagina,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Botao(
                    "Onde assistir",
                    Icons.done_rounded,
                    _avancarParaOndeAssistir,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Botao(
                    "Top 3 diário",
                    Icons.done_rounded,
                    _avancarParaTopTres,
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
