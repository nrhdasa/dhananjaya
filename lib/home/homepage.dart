import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../connectivity.dart';
import 'donation_month.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                  ElevatedButton.icon(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.receipt), label: const Text("Create Receipt")),
                  ElevatedButton.icon(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.userPlus), label: const Text("Create Donor")),
                  ElevatedButton.icon(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.listOl), label: const Text("Check Sevas")),
                  ElevatedButton.icon(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.userPlus), label: const Text("Create Demo"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Stats",
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
              // DonationsChart(donationsData: {
              //   'HKMJ': {'Feb-23': 382218.0, 'Jan-23': 3184451.0, 'Dec-22': 2680200.0, 'Nov-22': 1649761.0, 'Oct-22': 1582900.0, 'Sep-22': 5552100.0},
              //   'RKM': {'Feb-23': 989300.0, 'Jan-23': 362600.0, 'Dec-22': 779911.0, 'Nov-22': 1377200.0, 'Oct-22': 934900.0, 'Sep-22': 160900.0},
              // }),
              const DonationChart(),

              // Row(
              //   children: [
              //     // TextField(
              //     //   decoration: InputDecoration(label: Text("Search Donor")),
              //     // ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    ));
  }

  get_profile() async {
    var data = await Auth.getAPI();
    return data;
  }
}
