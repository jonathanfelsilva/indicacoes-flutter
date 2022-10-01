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

    var id = indicacao["id"];
    var titulo =
        tipoIndicacao == 'Série' ? indicacao["name"] : indicacao["title"];
    var descricao = indicacao["overview"];
    var pathImagem =
        "https://image.tmdb.org/t/p/w500/${indicacao["poster_path"]}";
    var nota = indicacao["vote_average"];
    var generos = indicacao["genres"];
    var dataLancamento = tipoIndicacao == "Série"
        ? indicacao["first_air_date"]
        : indicacao["release_date"];
    var lugaresDisponibilidade = indicacao["placesToWatch"] ?? [];

    Indicacao indicacaoTratada = Indicacao(
        id: id,
        titulo: titulo,
        descricao: descricao,
        pathImagem: pathImagem,
        nota: nota,
        generos: generos,
        tipo: tipoIndicacao,
        dataLancamento: dataLancamento,
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
        id: 1,
        titulo: "Nenhuma indicação encontrada",
        pathImagem:
            "https://cdn.pixabay.com/photo/2016/05/14/18/23/emoticon-1392275_960_720.png",
        descricao: "Parece que deu algo errado... por gentileza, clique no botão abaixo para tentar novamente.",
        nota: 0.0,
        generos: "",
        tipo: "",
        dataLancamento: "",
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

    var id = indicacao["id"];
    var titulo = tipo == 'Série' ? indicacao["name"] : indicacao["title"];
    var descricao = indicacao["overview"];
    var pathImagem =
        "https://image.tmdb.org/t/p/w500${indicacao["poster_path"]}";
    var nota = indicacao["vote_average"];
    var generos = indicacao["genres"];
    var dataLancamento = tipo == "Série"
        ? indicacao["first_air_date"]
        : indicacao["release_date"];
    var lugaresDisponibilidade = indicacao["placesToWatch"] ?? [];

    Indicacao indicacaoTratada = Indicacao(
        id: id,
        titulo: titulo,
        descricao: descricao,
        pathImagem: pathImagem,
        nota: nota,
        generos: generos,
        tipo: tipo,
        dataLancamento: dataLancamento,
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
        id: 1,
        titulo: "Nenhuma indicação encontrada",
        pathImagem:
            "https://cdn.pixabay.com/photo/2016/05/14/18/23/emoticon-1392275_960_720.png",
        descricao: "Parece que deu algo errado... por gentileza, clique no botão abaixo para tentar novamente.",
        nota: 0.0,
        generos: "",
        tipo: "",
        dataLancamento: "",
        lugaresDisponibilidade: [{}]);
  }
}

Future<List<Indicacao>> getTopThree(context, serieOuFilme) async {
  try {
    var dio = Dio();
    String path = '';

    if (serieOuFilme == 'Série') {
      path = 'http://localhost:3730/tv-series/top-three';
    } else {
      path = 'http://localhost:3730/movies/top-three';
    }

    var resposta = await dio.get(path);
    List indicacoes = resposta.data["data"];

    List<Indicacao> topTres = [];

    for (var i = 0; i < indicacoes.length; i++) {
      var indicacao = indicacoes[i];

      var id = indicacao["id"];
      var titulo =
          serieOuFilme == 'Série' ? indicacao["name"] : indicacao["title"];
      var descricao = indicacao["overview"];
      var pathImagem =
          "https://image.tmdb.org/t/p/w500${indicacao["poster_path"]}";
      var nota = indicacao["vote_average"];
      var generos = indicacao["genres"];
      var dataLancamento = serieOuFilme == "Série"
          ? indicacao["first_air_date"]
          : indicacao["release_date"];
      var lugaresDisponibilidade = indicacao["placesToWatch"] ?? [];

      Indicacao indicacaoTratada = Indicacao(
          id: id,
          titulo: titulo,
          descricao: descricao,
          pathImagem: pathImagem,
          nota: nota,
          generos: generos,
          tipo: serieOuFilme,
          dataLancamento: dataLancamento,
          lugaresDisponibilidade: lugaresDisponibilidade);

      topTres.add(indicacaoTratada);
    }

    return topTres;
  } catch (erro) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Ocorreu um erro ao obter a indicação. Por favor, tente novamente mais tarde.'),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    ));
    return [];
  }
}

Future<Indicacao> getCompleteData(context, Indicacao indicacao) async {
  try {
    var dio = Dio();
    String path = '';

    if (indicacao.tipo == 'Série') {
      path = 'http://localhost:3730/tv-series/findById/${indicacao.id}';
    } else {
      path = 'http://localhost:3730/movies/findById/${indicacao.id}';
    }

    var resposta = await dio.get(path);
    var item = resposta.data["data"];

    Indicacao indicacaoCompleta = Indicacao(
        id: item["id"],
        titulo: indicacao.tipo == 'Série' ? item["name"] : item["title"],
        descricao: item["overview"],
        pathImagem: "https://image.tmdb.org/t/p/w500${item["poster_path"]}",
        nota: item["vote_average"],
        generos: item["genres"],
        tipo: indicacao.tipo,
        dataLancamento: indicacao.tipo == "Série"
            ? item["first_air_date"]
            : item["release_date"],
        lugaresDisponibilidade: item["placesToWatch"] ?? []);

    return indicacaoCompleta;
  } catch (erro) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Ocorreu um erro ao obter a indicação. Por favor, tente novamente mais tarde.'),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    ));
    return Indicacao(
        id: 1,
        titulo: "Nenhuma indicação encontrada",
        pathImagem:
            "https://cdn.pixabay.com/photo/2016/05/14/18/23/emoticon-1392275_960_720.png",
        descricao: "Parece que deu algo errado... por gentileza, clique no botão abaixo para tentar novamente.",
        nota: 0.0,
        generos: "",
        tipo: "",
        dataLancamento: "",
        lugaresDisponibilidade: [{}]);
  }
}

Future<List<Indicacao>> getMovieTvSerieByName(
    context, nome, serieOuFilme) async {
  try {
    var dio = Dio();
    String path = '';

    if (serieOuFilme == 'Série') {
      path = 'http://localhost:3730/tv-series/findByName?name=$nome';
    } else {
      path = 'http://localhost:3730/movies/findByTitle?title=$nome';
    }

    var resposta = await dio.get(path);
    List resultado = resposta.data["data"];

    List<Indicacao> itens = [];

    for (var i = 0; i < resultado.length; i++) {
      var indicacao = resultado[i];

      var id = indicacao["id"];
      var titulo =
          serieOuFilme == 'Série' ? indicacao["name"] : indicacao["title"];
      var descricao = indicacao["overview"];
      var pathImagem =
          "https://image.tmdb.org/t/p/w500${indicacao["poster_path"]}";
      var nota = indicacao["vote_average"];
      var generos = indicacao["genres"];
      var dataLancamento = serieOuFilme == "Série"
          ? indicacao["first_air_date"]
          : indicacao["release_date"];
      var lugaresDisponibilidade = indicacao["placesToWatch"] ?? [];

      Indicacao indicacaoTratada = Indicacao(
          id: id,
          titulo: titulo,
          descricao: descricao,
          pathImagem: pathImagem,
          nota: nota,
          generos: generos,
          tipo: serieOuFilme,
          dataLancamento: dataLancamento,
          lugaresDisponibilidade: lugaresDisponibilidade);

      itens.add(indicacaoTratada);
    }
    return itens;
  } catch (erro) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Ocorreu um erro ao obter a indicação. Por favor, tente novamente mais tarde.'),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    ));
    return [];
  }
}
