import 'package:flutter/material.dart';
import '../widgets/color_tile.dart';

class ColorView extends StatelessWidget {
  const ColorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            child: const Text(
              'Выберите цвет приложения:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView(
              children: listColor
                  .map(
                    (item) => ColorTile(
                      color: item,
                    ),
                  )
                  .toList(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 100,
            child: ElevatedButton(
              child: const Text('Закрыть'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}