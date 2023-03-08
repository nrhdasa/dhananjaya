import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:sample/Resources/buttons.dart';
import 'auth_cubit.dart';

class AuthWidget extends StatefulWidget {
  final Widget? child;
  const AuthWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state == AuthState.signedOut) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "Your API is incorrect or not set. Please reset.",
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: () => context.go('/apipage'), child: const Text("Enter API"))
                ],
              ),
            );
          } else {
            return widget.child ?? const Text("Child Widget is not Mentioned");
          }
        });
  }
}
