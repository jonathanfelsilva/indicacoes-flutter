import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/widgets/botao_menor.dart';
import 'package:indicacoes/widgets/tiles/tile_top_indicacao.dart';

import '../config/cores.dart';
import '../models/indicacao.dart';

import '../services/api_service.dart' as api;
import '../widgets/tiles/tile_busca_titulo.dart';

class TelaBuscaTitulo extends StatefulWidget {
  const TelaBuscaTitulo(this.tipoIndicacao, {Key? key}) : super(key: key);

  final String tipoIndicacao;

  @override
  State<TelaBuscaTitulo> createState() => _TelaBuscaTituloState();
}

class _TelaBuscaTituloState extends State<TelaBuscaTitulo> {
  TextEditingController nomeController = TextEditingController();
  List<Indicacao> itens = [];

  Future<void> _buscarDados() async {
    List<Indicacao> resultado = await api.getMovieTvSerieByName(
        context, nomeController.text, widget.tipoIndicacao);

    setState(() {
      itens = resultado;
    });
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
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Qual ${widget.tipoIndicacao.toLowerCase()} você quer ver?",
                      style: GoogleFonts.quicksand(
                        fontSize: 60,
                        fontWeight: FontWeight.w600,
                        color: Cores.ROXO,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * 0.8
                          : MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Cores.CINZA),
                        controller: nomeController,
                        decoration: InputDecoration(
                          prefixIconColor: Cores.ROXO,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.search_rounded,
                              color: Cores.ROXO,
                            ),
                          ),
                          hintText: "Digite um título",
                          contentPadding: const EdgeInsets.all(20.0),
                          hintStyle: GoogleFonts.quicksand(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Cores.CINZA),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Cores.ROXO,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Cores.ROXO,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BotaoMenor(
                    "Buscar",
                    Icons.search_rounded,
                    () async {
                      await _buscarDados();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Divider(
                    indent: MediaQuery.of(context).size.width * 0.15,
                    endIndent: MediaQuery.of(context).size.width * 0.15,
                    thickness: 4,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: itens
                            .map(
                              (indicacao) => TileBuscaTitulo(indicacao),
                            )
                            .toList()),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
