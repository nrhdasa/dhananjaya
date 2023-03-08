import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../connectivity.dart';
import 'analysis.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var profile;
  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hare Krishna", style: texts.titleMedium),
                      FutureBuilder<dynamic>(
                        future: get_profile(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            print(snapshot.data);
                            return SizedBox(
                              width: 200,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  snapshot.data != null ? snapshot.data['full_name'] : "",
                                  // style: texts.headlineMedium,
                                  overflow: TextOverflow.fade,
                                  style: texts.displaySmall!.copyWith(color: colors.tertiary),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Hero(
                        tag: "search-donor",
                        child: IconButton(
                            iconSize: 50,
                            color: colors.primary,
                            onPressed: () {
                              context.go('/searchdonor');
                            },
                            icon: const Icon(Icons.search)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // IconButton(
                      //     color: colors.primary,
                      //     onPressed: () {
                      //       // Auth.discardAPI();
                      //     },
                      //     icon: Icon(Icons.logout)),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Shortcuts",
                style: texts.labelLarge!.copyWith(color: colors.onBackground),
              ),
              Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), shape: BoxShape.rectangle, color: colors.onBackground),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton.icon(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.userPlus), label: const Text("Create Donor")),
                  ElevatedButton.icon(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.listOl), label: const Text("Check Sevas")),
                  ElevatedButton.icon(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.userPlus), label: const Text("Create Demo"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                child: Text(
                  "Welcome to Dhananjaya Donor Management Application.",
                  textAlign: TextAlign.center,
                  style: texts.displaySmall!.copyWith(color: colors.onBackground),
                  overflow: TextOverflow.clip,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future get_profile() async {
    var data = await Auth.getAPI();
    return data;
  }
}
