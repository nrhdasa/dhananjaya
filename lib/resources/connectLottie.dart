import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ConnectLottie extends StatefulWidget {
  const ConnectLottie({Key? key}) : super(key: key);

  @override
  State<ConnectLottie> createState() => _ConnectLottieState();
}

class _ConnectLottieState extends State<ConnectLottie> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/connect.json"),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 5, end: 1),
            duration: Duration(milliseconds: 5000),
            curve: Curves.easeInCirc,
            onEnd: () {},
            builder: (context, double val, child) {
              return Transform.scale(
                scale: val,
                child: child,
              );
            },
            child: Text(""),
          ),
        ],
      )),
    );
  }
}
