import 'package:dhananjaya/donor/analysis.dart';
import 'package:dhananjaya/donor/donation.dart';
import 'package:dhananjaya/donor/donor_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../resources/connectLottie.dart';
import '../resources/elements.dart';
import 'connection.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'contacts.dart';

class DonorPage extends StatefulWidget {
  final String id;
  const DonorPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.goNamed("create_receipt", params: {'id': widget.id});
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
            child: BlocProvider(
                create: (_) => DonorCubit(donorId: widget.id),
                child: BlocBuilder<DonorCubit, Data>(
                  builder: (_, fetchedData) {
                    print(fetchedData);
                    if (fetchedData.state == FetchState.loading) {
                      return ConnectLottie();
                    } else {
                      Map data = fetchedData.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    padding: const EdgeInsets.only(left: 20, bottom: 12),
                                    decoration: BoxDecoration(
                                        boxShadow: shadows1,
                                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30)),
                                        gradient: LinearGradient(colors: [colors.primaryContainer, colors.primaryContainer.withOpacity(.3)])),
                                    alignment: Alignment.bottomLeft,
                                    child: TabBar(
                                      tabs: [
                                        Tab(
                                          icon: FaIcon(
                                            FontAwesomeIcons.phone,
                                            color: colors.onPrimaryContainer,
                                          ),
                                        ),
                                        Tab(
                                          icon: FaIcon(
                                            FontAwesomeIcons.chartSimple,
                                            color: colors.onPrimaryContainer,
                                          ),
                                        ),
                                        Tab(
                                          icon: FaIcon(
                                            FontAwesomeIcons.circleDollarToSlot,
                                            color: colors.onPrimaryContainer,
                                          ),
                                        ),
                                        Tab(
                                          icon: FaIcon(
                                            FontAwesomeIcons.placeOfWorship,
                                            color: colors.onPrimaryContainer,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    padding: const EdgeInsets.only(bottom: 10, left: 30),
                                    alignment: Alignment.bottomCenter,
                                    decoration:
                                        BoxDecoration(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)), gradient: LinearGradient(colors: [colors.primary, colors.secondary])),
                                    child: SelectableText(
                                      data['full_name'],
                                      style: texts.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: colors.onSecondary),
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    left: 10,
                                    child: IconButton(
                                        color: colors.inversePrimary,
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                        ),
                                        onPressed: () => Navigator.pop(context)),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 20,
                                    child: IconButton(
                                        color: colors.inversePrimary,
                                        icon: const Icon(
                                          Icons.verified,
                                          size: 40,
                                          color: Color.fromARGB(255, 253, 216, 5),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text(
                                                    "This Donor is a Patron.",
                                                    style: texts.bodyLarge,
                                                  ),
                                                );
                                              });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 232,
                              child: TabBarView(
                                children: [
                                  ContactsTab(data: data),
                                  AnalysisTab(data: data),
                                  DonationTab(data: data),
                                  const Icon(Icons.directions_bike),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ))),
      ),
    );
  }
}
