import 'package:dhananjaya/cubits/auth_widget.dart';
import 'package:dhananjaya/cubits/internet_cubit.dart';
import 'package:dhananjaya/home/search_page.dart';
import 'package:dhananjaya/resources/success_API.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'apipage.dart';
import 'cubits/auth_cubit.dart';
import 'cubits/internet_widget.dart';
import 'donor/donor.dart';
import 'home/homepage.dart';

final AuthCubit _authCubit = AuthCubit();
final InternetCubit _internetCubit = InternetCubit();

class DBlocBuilder extends StatelessWidget {
  final Widget? child;
  DBlocBuilder({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(_authCubit.state);
    return BlocProvider<InternetCubit>.value(
        value: _internetCubit,
        child: BlocProvider<AuthCubit>.value(
            value: _authCubit,
            child: InternetWidget(
              child: AuthWidget(child: child),
            )));
  }
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => DBlocBuilder(child: Homepage()),
      routes: <RouteBase>[
        GoRoute(
          path: 'successapi',
          builder: (BuildContext context, GoRouterState state) => SuccessAPI(),
        ),
        GoRoute(
          path: 'apipage',
          builder: (BuildContext context, GoRouterState state) => Apipage(),
        ),
        GoRoute(path: 'searchdonor', builder: (BuildContext context, GoRouterState state) => DBlocBuilder(child: SearchDonor()), routes: <RouteBase>[
          GoRoute(
              name: "donor",
              path: "donor/:id",
              builder: (BuildContext context, GoRouterState state) => DBlocBuilder(
                      child: DonorPage(
                    id: state.params["id"]!,
                  )))
        ]),
      ],
    ),
  ],
);
