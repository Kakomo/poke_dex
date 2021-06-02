
import 'package:flutter/material.dart';
import 'package:poke_dex/classes/app_images.dart';
import 'package:poke_dex/http/webclient.dart';
import 'package:poke_dex/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarToday',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.black45,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.bg),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Text(
                      'Descobrir os Pokémons na sua região nunca foi tão fácil!',
                      style: TextStyle(
                        fontFamily: 'Pokemon',
                        fontSize: 24,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Color.fromRGBO(0, 0, 139,1),
                      ),
                    ),
                    Text(
                      'Descobrir os Pokémons na sua região nunca foi tão fácil!',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: 'Pokemon',
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Saber quais Pokémons estão ao seu redor é fundamental para se tornar um verdadeiro Mestre Pokémon ',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 18
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text(
                      'COMEÇAR A USAR',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      onPrimary: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        )
    );
  }
}