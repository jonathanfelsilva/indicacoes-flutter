import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/screens/tela_escolha_indicacao.dart';
import 'package:indicacoes/screens/tela_indicacao.dart';

import '../config/cores.dart';
import '../widgets/botao.dart';

class TelaEscolhaTipoIndicacao extends StatefulWidget {
  const TelaEscolhaTipoIndicacao({Key? key}) : super(key: key);

  @override
  State<TelaEscolhaTipoIndicacao> createState() =>
      _TelaEscolhaTipoIndicacaoState();
}

class _TelaEscolhaTipoIndicacaoState extends State<TelaEscolhaTipoIndicacao> {
  TextEditingController telefoneController = TextEditingController();

  void _avancarPagina() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TelaEscolhaIndicacao(),
    ));
  }

  void _avancarParaRecomendacaoAleatoria() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TelaIndicacao("", "", true),
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
                "assets/images/Tela_tipo_indicacao.svg",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(
                height: 50,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Qual tipo de indicação\nvocê quer?",
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
                    "Indicação detalhada",
                    Icons.done_rounded,
                    _avancarPagina,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Botao(
                    "Indicação aleatória",
                    Icons.done_rounded,
                    _avancarParaRecomendacaoAleatoria,
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
