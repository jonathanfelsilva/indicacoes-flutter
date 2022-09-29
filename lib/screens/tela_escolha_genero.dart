import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/screens/tela_indicacao.dart';

import '../config/cores.dart';
import '../widgets/botao.dart';

import '../services/api_service.dart' as api;

class TelaEscolhaGenero extends StatefulWidget {
  const TelaEscolhaGenero(this.tipoIndicacao, {Key? key}) : super(key: key);

  final String tipoIndicacao;

  @override
  State<TelaEscolhaGenero> createState() => _TelaEscolhaGeneroState();
}

class _TelaEscolhaGeneroState extends State<TelaEscolhaGenero> {
  String? genero;

  final formKey = GlobalKey<FormState>();

  void _avancarPagina() {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            TelaIndicacao(widget.tipoIndicacao, genero, false),
      ));
    }
  }

  Future<List<String>> _getGenres() async {
    List<String> genres = await api.getGenres(context, widget.tipoIndicacao);
    return genres;
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
      body: FutureBuilder<List<String>>(
        future: _getGenres(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
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
                    SvgPicture.asset(
                      "assets/images/Tela_2.svg",
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Escolha um gênero",
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
                    Form(
                      key: formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width * 0.8
                            : MediaQuery.of(context).size.width / 3,
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.modalBottomSheet(
                            searchFieldProps: TextFieldProps(
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Cores.ROXO,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Digite aqui para buscar",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Cores.AZUL)),
                              ),
                            ),
                            showSearchBox: true,
                            listViewProps: const ListViewProps(
                              physics: BouncingScrollPhysics(),
                            ),
                            searchDelay: const Duration(seconds: 0),
                          ),
                          items: snapshot.data!,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Gênero",
                              hintStyle: GoogleFonts.quicksand(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Cores.ROXO,
                              ),
                              labelStyle: GoogleFonts.quicksand(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Cores.ROXO,
                              ),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                          ),
                          onChanged: (value) {
                            genero = value;
                          },
                          validator: (texto) {
                            if (texto == null) {
                              return "Escolha um gênero para continuar";
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Botao(
                      "Confirmar",
                      Icons.done_rounded,
                      _avancarPagina,
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
