import 'package:poke_dex/database/app_database.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';


class PokemonDao {

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_nome TEXT, '
      '$_num TEXT, '
      '$_img TEXT, '
      '$_tipo TEXT, '
      '$_tamanho TEXT, '
      '$_peso TEXT, '
      '$_fraco TEXT, '
      '$_liked INTEGER)';
  static const String _tableName = 'characters';
  static const String _num = 'num';
  static const String _nome = 'nome';
  static const String _img = 'img';
  static const String _tipo = 'tipo';
  static const String _tamanho = 'name';
  static const String _peso = 'peso';
  static const String _fraco = 'fraco';
  static const String _liked = 'liked';

  save(Pokemon pokemon) async {
    final Database db = await getDatabase();
    var itemExists = await find(pokemon.nome);
    Map<String, dynamic> pokeMap = _toMap(pokemon);

    if(itemExists.length == 0)
      return db.insert(_tableName, pokeMap);

    return await db.update(
        _tableName,
        pokeMap,
        where: '$_nome = ?',
        whereArgs: [pokemon.nome]
    );
  }

  Future<List<Pokemon>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    return _toList(result);
  }

  Future<List<Pokemon>> find(String name) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
        _tableName,
        where: '$_nome = ?',
        whereArgs: [name]
    );

    return _toList(result);
  }

  Map<String, dynamic> _toMap(Pokemon pokemon) {
    final Map<String, dynamic> pokemonMap = Map();
    pokemonMap[_num] = pokemon.num;
    pokemonMap[_nome] = pokemon.nome;
    pokemonMap[_img] = pokemon.img;
    pokemonMap[_tipo] = pokemon.tipo;
    pokemonMap[_tamanho] = pokemon.tamanho;
    pokemonMap[_peso] = pokemon.nome;
    pokemonMap[_fraco] = pokemon.fraco;
    pokemonMap[_liked] = pokemon.liked;

    return pokemonMap;
  }

  List<Pokemon> _toList(List<Map<String, dynamic>> result) {
    final List<Pokemon> pokemons = [];
    for (Map<String, dynamic> row in result) {
      final Pokemon pokemon = Pokemon(
        num: row[_num],
        nome: row[_nome],
        img: row[_img],
        tipo: row[_tipo],
        tamanho: row[_tamanho],
        peso: row[_peso],
        fraco: row[_fraco],
        liked: row[_liked],
      );

      pokemons.add(pokemon);
    }

    return pokemons;
  }
}