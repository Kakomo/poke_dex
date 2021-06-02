import 'package:flutter/material.dart';
import 'package:poke_dex/database/pokemon_dao.dart';
import 'package:poke_dex/http/webclient.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/components/liked.dart';

class PokeInfo extends StatefulWidget {
  Pokemon pokemon;

  PokeInfo(
      {required this.pokemon});

  @override
  _PokeInfoState createState() => _PokeInfoState();
}

class _PokeInfoState extends State<PokeInfo> {
  int? _favorite = 0;
  final PokemonDao dao = PokemonDao();

  @override
  void initState() {
    super.initState();
    dao.find(widget.pokemon.nome)
        .then((pokemons) {
      setState(() {
        if(pokemons.length > 0)
          _favorite = pokemons[0].liked;
        else
          _favorite = 0;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.pokemon.nome),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 650,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 550,
                    color: Color.fromRGBO(149, 146, 147, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  color: Colors.white,
                                  child: Image.network(widget.pokemon.img)),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Expanded(
                              child: Align(
                                child: Liked(
                                    isSelected: _favorite == 0 ? false: true,
                                    onPressed: () async {
                                      dao.save(Pokemon(
                                          num: widget.pokemon.num,
                                          nome: widget.pokemon.nome,
                                          img: widget.pokemon.img,
                                          tipo: widget.pokemon.tipo,
                                          tamanho: widget.pokemon.tamanho,
                                          peso: widget.pokemon.peso,
                                          fraco: widget.pokemon.fraco,
                                          liked: _favorite == 0 ? 1 : 0
                                      ));

                                      setState((){
                                        _favorite = _favorite == 0 ? 1 : 0;
                                      });
                                    }
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tipo:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                ),
                              ),
                              Text(widget.pokemon.tipo,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                ),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Peso:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                ),
                              ),
                              Text(widget.pokemon.peso,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                ),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Altura:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                ),
                              ),
                              Text(widget.pokemon.tamanho,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                ),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fraco Contra:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                ),
                              ),
                              Text(widget.pokemon.fraco,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Retornar'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
