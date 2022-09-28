import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:indicacoes/models/indicacao.dart';

Future<List<String>> getGenres(context, tipoIndicacao) async {
  try {
    var dio = Dio();
    String path = '';

    if (tipoIndicacao == 'Série') {
      path = 'http://localhost:3730/tv-series/genres';
    } else {
      path = 'http://localhost:3730/movies/genres';
    }

    var resposta = await dio.get(path);
    List<dynamic> returnedGenres = resposta.data["data"];
    List<String> genres = returnedGenres.map((genre) {
      return '$genre';
    }).toList();

    return genres;
  } catch (erro) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Ocorreu um erro ao obter a lista de gêneros. Por favor, tente novamente mais tarde.'),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    ));
    return [];
  }
}

Future<Indicacao> getRecommendation(context, tipoIndicacao, genero) async {
  try {
    var dio = Dio();
    String path = '';

    if (tipoIndicacao == 'Série') {
      path = 'http://localhost:3730/tv-series/recommendation?genre=$genero';
    } else {
      path = 'http://localhost:3730/movies/recommendation?genre=$genero';
    }

    var resposta = await dio.get(path);
    var indicacao = resposta.data["data"];

    var titulo =
        tipoIndicacao == 'Série' ? indicacao["name"] : indicacao["title"];
    var descricao = indicacao["overview"];
    var pathImagem =
        "https://image.tmdb.org/t/p/w500/${indicacao["poster_path"]}";
    var nota = indicacao["vote_average"];
    var generos = indicacao["genres"];
    var lugaresDisponibilidade = indicacao["placesToWatch"] ?? [];

    Indicacao indicacaoTratada = Indicacao(
        titulo: titulo,
        descricao: descricao,
        pathImagem: pathImagem,
        nota: nota,
        generos: generos,
        lugaresDisponibilidade: lugaresDisponibilidade);

    return indicacaoTratada;
  } catch (erro) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Ocorreu um erro ao obter a indicação. Por favor, tente novamente mais tarde.'),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    ));
    return Indicacao(
        titulo: "Nenhuma indicação encontrada",
        pathImagem:
            "https://cdn.pixabay.com/photo/2016/05/14/18/23/emoticon-1392275_960_720.png",
        descricao: "Parece que deu algo errado... por gentileza, clique no botão abaixo para tentar novamente.",
        nota: 0.0,
        generos: "",
        lugaresDisponibilidade: [{}]);
  }
}

Future<Indicacao> getRandomRecommendation(context) async {
  try {
    var dio = Dio();
    String path = 'http://localhost:3730/randomizer';

    var resposta = await dio.get(path);

    var tipo = resposta.data["data"]["type"];

    var indicacao = resposta.data["data"]["recommendation"];

    var titulo = tipo == 'Série' ? indicacao["name"] : indicacao["title"];
    var descricao = indicacao["overview"];
    var pathImagem =
        "https://image.tmdb.org/t/p/w500${indicacao["poster_path"]}";
    var nota = indicacao["vote_average"];
    var generos = indicacao["genres"];
    var lugaresDisponibilidade = indicacao["placesToWatch"] ?? [];

    Indicacao indicacaoTratada = Indicacao(
        titulo: titulo,
        descricao: descricao,
        pathImagem: pathImagem,
        nota: nota,
        generos: generos,
        lugaresDisponibilidade: lugaresDisponibilidade);

    return indicacaoTratada;
  } catch (erro) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Ocorreu um erro ao obter a indicação. Por favor, tente novamente mais tarde.'),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    ));
    return Indicacao(
        titulo: "Nenhuma indicação encontrada",
        pathImagem:
            "https://cdn.pixabay.com/photo/2016/05/14/18/23/emoticon-1392275_960_720.png",
        descricao: "Parece que deu algo errado... por gentileza, clique no botão abaixo para tentar novamente.",
        nota: 0.0,
        generos: "",
        lugaresDisponibilidade: [{}]);
  }
}
