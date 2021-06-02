


import 'package:flutter/material.dart';
import 'package:poke_dex/database/pokemon_dao.dart';
import 'package:poke_dex/models/pokemon.dart';

class FavoriteScreen extends StatelessWidget {
  final PokemonDao pokemonDao = PokemonDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Meus Pokémons',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: FutureBuilder<List<Pokemon>>(
            future: pokemonDao.findAll(),
            builder: (context, snapshot) {
              late List<Pokemon> items = snapshot.data!;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Pokemon pokemon = items[index];
                            return PokemonItem(pokemon);
                          });
                    }
                  }
                  return Text('Erro ao carregar personagens');
              }

              return Text('Erro');
            },
          ),
        ),
      ]),
    );
  }
}
class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;

  PokemonItem(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
            NetworkImage(pokemon.img),
            backgroundColor: Colors.white,
          ),
          title: Text(pokemon.nome, style: TextStyle(fontSize: 20),),
          subtitle: Text('Tipo:${pokemon.tipo}                        Fraco:${pokemon.fraco}'),

        ),
      ),
    );
  }
}