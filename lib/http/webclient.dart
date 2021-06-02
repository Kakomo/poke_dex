


import 'dart:convert';

import 'package:http/http.dart';
import 'package:poke_dex/models/pokemon.dart';


class PokeWebClient{

  Future<List<Pokemon>> findAll() async {
    var url = Uri.parse('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    final Response response = await get(url);
    final Map<String,dynamic> decodedJson = jsonDecode(response.body);
    final List<Pokemon> pokemons = [];
    final List<dynamic> results = decodedJson['pokemon'];
    for (Map<String, dynamic> element in results) {
      final Pokemon pokemon = Pokemon(
        num: element['num'],
        nome: element['name'],
        img: element['img'],
        tipo: element['type'][0],
        tamanho: element['height'],
        peso: element['weight'],
        fraco: element['weaknesses'][0],

      );
      pokemons.add(pokemon);
    }
    return pokemons;
  }
}
