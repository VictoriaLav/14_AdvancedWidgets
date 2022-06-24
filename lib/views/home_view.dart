import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/weather_icons.dart';
import '../widgets/inner_shadow.dart';
import 'color_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final double _radiusSun = 30;
  double _currentSliderValue = 0.5;
  bool selected = false;
  double scaleValue = 1;

  late AnimationController controller;
  late Animation<Size> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    animation = Tween<Size>(begin: Size(_radiusSun * 10 / 3, _radiusSun * 7 / 3), end: Size(_radiusSun * 20 / 3, _radiusSun * 14 / 3)).animate(
        CurvedAnimation(
          curve: Curves.fastOutSlowIn,
          parent: controller,
        ))..addListener(() {
      setState(() {});
    });

    print(controller.value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void scalePlus(double scale) async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 30), () {
        setState(() {
          scaleValue += scale;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: const Icon(Icons.palette_outlined),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ColorView()));
              }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text('Укажите значение облачности:'),
              Text(_currentSliderValue.toStringAsFixed(3)),
              CupertinoSlider(
                key: const Key('slider'),
                value: _currentSliderValue,
                min: 0,
                max: 1,
                activeColor: themeProvider.currentColor,
                thumbColor: themeProvider.currentColor,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              const SizedBox(height: 20,),
              AnimatedBuilder(
                animation: animation,
                child: GestureDetector(
                  onTap: () {
                    controller.forward();
                    if (selected) {
                      scalePlus(-0.1);
                    } else {
                      scalePlus(0.1);
                    }
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          height: _radiusSun * 7 / 3,
                          width: _radiusSun * 10 / 3,
                          child: CustomPaint(
                            painter: WeatherIcon(
                              radius: _radiusSun,
                              cloudiness: _currentSliderValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                builder: (cnt, child) {
                  return Transform.scale(
                    scale: scaleValue,
                    child: selected
                        ? Column(
                            children: <Widget>[
                              child!,
                              const SizedBox(height: 20),
                              Text(_currentSliderValue < 0.3
                                  ? 'Ясно\n  30°'
                                  : (_currentSliderValue > 0.8
                                      ? 'Дождь\n    18°'
                                      : 'Облачно\n      24°')),
                            ],
                          )
                        : child,
                  );
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InnerShadow(
                    blur: 2,
                    color: themeProvider.currentColor,
                    offset: const Offset(2, 2),
                    child: Text(
                      'Погода',
                      style: TextStyle(
                          fontSize: 100,
                          color: themeProvider.currentColor[50]
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}