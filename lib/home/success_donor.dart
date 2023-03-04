import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SuccessDonor extends StatefulWidget {
  const SuccessDonor({Key? key}) : super(key: key);

  @override
  State<SuccessDonor> createState() => _SuccessDonorState();
}

class _SuccessDonorState extends State<SuccessDonor> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/success.json"),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 2, end: 1),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInCirc,
            onEnd: () {
              Future.delayed(const Duration(seconds: 5)).then((value) {
                Navigator.of(context).pop();
              });
            },
            builder: (context, double val, child) {
              return Transform.scale(
                scale: val,
                child: child,
              );
            },
            child: Text(
              "Success!",
              style: TextStyle(fontSize: 40, color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ],
      )),
    );
  }
}
