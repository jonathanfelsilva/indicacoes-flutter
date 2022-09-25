import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/screens/tela_escolha_indicacao.dart';

import '../config/cores.dart';
import '../widgets/botao.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  TextEditingController telefoneController = TextEditingController();

  void _avancarPagina() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const TelaEscolhaIndicacao(),
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
              SvgPicture.asset(
                "assets/images/Tela_inicial.svg",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
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
                  "Escolha uma opção e deixe\no resto com a gente.",
                  style: GoogleFonts.quicksand(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
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
                    _avancarPagina,
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
