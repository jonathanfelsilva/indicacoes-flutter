import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/cores.dart';

class BotaoMenor extends StatelessWidget {
  const BotaoMenor(this.texto, this.icone, this.funcaoOnPressed, {Key? key})
      : super(key: key);

  final String texto;
  final IconData icone;
  final VoidCallback funcaoOnPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(42),
          )),
          backgroundColor: MaterialStateProperty.all(
            Cores.AZUL,
          ),
        ),
        onPressed: funcaoOnPressed,
        child: Text(
          texto,
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
