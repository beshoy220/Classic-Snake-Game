import 'package:flutter/material.dart';
import 'package:snake.io/screens/game_screen.dart';
import 'package:snake.io/screens/setting_screen.dart';
import 'package:snake.io/screens/skin_color_screen.dart';
import 'package:snake.io/logic/shared_pref.dart';
import 'package:snake.io/provider/color_provider_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var TextCard = const ['Get faster!', 'Get more Apples!', 'Better earning!'];
  var IconCard = const [
    Icons.speed,
    Icons.spoke_rounded,
    Icons.monetization_on_outlined
  ];

  var money = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
              icon: const Icon(Icons.settings))
        ],
        title: FutureBuilder(
          future: getCoin(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            return Row(children: [
              const Icon(Icons.monetization_on),
              Text(' ${snapshot.data}')
            ]);
          },
        ),
      ),
      body: FutureBuilder(
          future: getColor(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Column(children: [
              SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'You Can Choose Your Skin By ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      ' Clicking The Snake !',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SkinColorScreen()));
                  },
                  child: ListView.builder(
                    controller: ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 180, right: 180, top: 8),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(colors[snapshot.data]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GameScreen()));
                        },
                        child: Text('Start',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(colors[snapshot.data]),
                            ))),
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: TextCard.length,
                    itemBuilder: ((BuildContext context, index) {
                      return Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                                color: Color(colors[snapshot.data]),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Icon(
                                      IconCard[index],
                                      size: 60,
                                      color: Colors.black,
                                    )),
                                Text(
                                  TextCard[index],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        '15 \$',
                                        style: TextStyle(
                                            color: Color.fromARGB(192, 0, 0, 0),
                                            fontSize: 30),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(171, 0, 0, 0),
                            ),
                            child: const Icon(
                              Icons.lock_open_rounded,
                              size: 40,
                            ),
                          ),
                        )
                      ]);
                    }),
                  )),
            ]);
          }),
    );
  }
}
