import 'package:dhananjaya/cubits/internet_cubit.dart';
import 'package:dhananjaya/receipt/create_receipt.dart';
import 'package:dhananjaya/search/search_page.dart';
import 'package:dhananjaya/resources/success_API.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'cubits/internet_widget.dart';
import 'donor/donor.dart';
import 'search/filters_page.dart';
import 'home/homepage.dart';

final InternetCubit _internetCubit = InternetCubit();

class DBlocBuilder extends StatelessWidget {
  final Widget? child;
  const DBlocBuilder({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetCubit>.value(value: _internetCubit, child: InternetWidget(child: child));
  }
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const DBlocBuilder(child: Homepage()),
      routes: <RouteBase>[
        GoRoute(
          path: 'successapi',
          builder: (BuildContext context, GoRouterState state) => const SuccessAPI(),
        ),
        GoRoute(path: 'searchdonor', builder: (BuildContext context, GoRouterState state) => const DBlocBuilder(child: SearchDonor()), routes: <RouteBase>[
          GoRoute(
            name: "filters_page",
            path: "filters_page",
            builder: (context, state) => DBlocBuilder(
              child: FilterPage(),
            ),
          ),
          GoRoute(
            name: "donor",
            path: "donor/:id",
            builder: (BuildContext context, GoRouterState state) => DBlocBuilder(
              child: DonorPage(
                id: state.params["id"]!,
              ),
            ),
            routes: <RouteBase>[
              GoRoute(
                name: "create_receipt",
                path: "create_receipt",
                builder: (context, state) => DBlocBuilder(
                  child: CreateReceipt(
                    id: state.params["id"]!,
                  ),
                ),
              ),
            ],
          )
        ]),
      ],
    ),
  ],
);
