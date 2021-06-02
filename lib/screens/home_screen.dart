import 'package:flutter/material.dart';
import 'package:poke_dex/http/webclient.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/screens/favorite_screen.dart';
import 'package:poke_dex/screens/poke_info.dart';

class HomeScreen extends StatelessWidget {
  final PokeWebClient webClient = PokeWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'PokeDex',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: FutureBuilder<List<Pokemon>>(
            future: webClient.findAll(),
            builder: (context, snapshot) {
              late List<Pokemon> items = snapshot.data!;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Center(
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
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(items[index].img),
                                    backgroundColor: Colors.white,
                                  ),
                                  title: Text(
                                    items[index].nome,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(items[index].num,
                                      style: TextStyle(fontSize: 16)),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PokeInfo(
                                          pokemon: Pokemon(
                                            num: items[index].num,
                                            nome: items[index].nome,
                                            img: items[index].img,
                                            tipo: items[index].tipo,
                                            tamanho: items[index].tamanho,
                                            peso: items[index].peso,
                                            fraco: items[index].fraco,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.favorite,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FavoriteScreen()),
          );
        },
      ),
    );
  }
}
