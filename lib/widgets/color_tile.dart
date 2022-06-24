import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

final List<MaterialColor> listColor = [
  Colors.indigo,
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
];

class ColorTile extends StatefulWidget {
  const ColorTile({Key? key, required this.color}) : super(key: key);
  final MaterialColor color;

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      onTap: () {
        themeProvider.toggle(widget.color);
      },
      title: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          height: 50,
          color: widget.color,
          // alignment: Alignment.center,
          child: themeProvider.currentColor == widget.color
              ? Icon(Icons.check, color: Colors.white)
              : Text(''),
        ),
      ),
    );
  }
}