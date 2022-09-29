import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indicacoes/screens/tela_inicial.dart';

import 'config/cores.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Indicações',
        theme: ThemeData(
          textTheme: TextTheme(
              subtitle1: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Cores.ROXO,
          )),
          primaryColor: Cores.AZUL,
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(
          child: TelaInicial(),
        ));
  }
}
