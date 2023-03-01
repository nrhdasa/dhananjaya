import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../resources/no_internet.dart';
import 'internet_cubit.dart';

class InternetWidget extends StatefulWidget {
  final Widget? child;
  const InternetWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<InternetWidget> createState() => _InternetWidgetState();
}

class _InternetWidgetState extends State<InternetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state == InternetState.initial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state == InternetState.lost) {
            return NoInternet();
          }
          if (state == InternetState.gained) {
            return widget.child ?? const Text("App Error1");
          }
          return const Text("App Error2");
        });
  }
}

// class NoConnectionWidget extends StatelessWidget {
//   const NoConnectionWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Image.asset(
//         "assets/error/No Connection.png",
//         fit: BoxFit.fill,
//       )),
//     );
//   }
// }
