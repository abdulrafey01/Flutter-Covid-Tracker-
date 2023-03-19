import 'dart:async';

import 'package:covid_19_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 8),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WorldStates()));
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: const Center(
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('images/virus.png'))),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                        child: child, angle: _controller.value * 2 * math.pi);
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            const Text(
              "Covid 19\nTracker App",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
