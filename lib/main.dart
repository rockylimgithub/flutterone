import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterone/games/binchgame/binchgame.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    bool isClicked = false;
    final _game = BinchGame();
    return Scaffold(
      body: GameWidget(
        game: _game,
        overlayBuilderMap: {
          'hello': (context, BinchGame game) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            game.velocity.x = -1;
                          },
                          child: Text('L'),
                        ),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                game.velocity.y = -1;
                              },
                              child: Text('Up'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                game.velocity.x = 0;
                                game.velocity.y = 0;
                              },
                              child: Text('Pause'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                game.velocity.y = 1;
                              },
                              child: Text('Down'),
                            ),
                          ],
                        ),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            game.velocity.x = 1;
                          },
                          child: Text('R'),
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      height: 50,
                    ),
                  ]),
                ],
              ),
            );
          }
        },
        initialActiveOverlays: const ['hello'],
      ),
    );
  }
}
