import 'package:flutter/material.dart';
import 'package:snake.io/logic/shared_pref.dart';
import 'package:snake.io/screens/home_screen.dart';
import 'package:snake.io/provider/color_provider_list.dart';

class SkinColorScreen extends StatefulWidget {
  const SkinColorScreen({Key? key}) : super(key: key);

  @override
  State<SkinColorScreen> createState() => _SkinColorScreenState();
}

class _SkinColorScreenState extends State<SkinColorScreen> {
  var snake_button_color = 0xF5A1F800;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          snake_button_color = colors[index];
                        });
                        setColor(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(colors[index]),
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FutureBuilder(
                future: getColor(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  return ListView.builder(
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
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: getColor(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          child: Text('Done !',
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(colors[snapshot.data]),
                              ))),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
