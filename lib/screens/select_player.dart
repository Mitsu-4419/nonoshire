import 'package:flutter/material.dart';
import './game_Screen.dart';

class SelectPlayer extends StatelessWidget {
  static const routeName = '/selectPlayer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('Assets/background/office_bg3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'Assets/background/select_title.png',
                  width: 295,
                ),
                SizedBox(
                  height: 55,
                ),
                Align(
                  alignment: Alignment(-0.6, 0.0),
                  child: Container(
                    height: 150,
                    child: GestureDetector(
                      child: Container(
                          width: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('Assets/faces/man/meanMan1.png'),
                              fit: BoxFit.cover,
                            ), // button text
                          )),
                      onTap: () {
                        Navigator.of(context).pushNamed(GameScreen.routeName);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment(0.6, 0.0),
                  child: Container(
                    height: 150,
                    child: GestureDetector(
                      child: Hero(
                        tag: 'woman',
                        child: Container(
                            width: 135,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'Assets/faces/woman/meanWoman1.png'),
                                fit: BoxFit.cover,
                              ), // button text
                            )),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(GameScreen.routeName);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
