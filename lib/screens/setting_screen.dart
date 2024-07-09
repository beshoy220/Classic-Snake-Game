import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {}, child: const Text('Reset game')),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: const [
                  Text(
                      '  Note: by resetting the game you will lose all progress '),
                  Text('you had done')
                ],
              ),
            )
          ],
        ));
  }
}
