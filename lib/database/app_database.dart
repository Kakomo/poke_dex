import 'package:path/path.dart';
import 'package:poke_dex/database/pokemon_dao.dart';
import 'package:sqflite/sqflite.dart';


Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'harry.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(PokemonDao.tableSql);
    },
    version: 1,
  );
}