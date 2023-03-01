import 'package:flutter/material.dart';

import '../resources/connectLottie.dart';
import '../resources/elements.dart';
import 'addresses.dart';
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
        body: FutureBuilder<dynamic>(
          future: getDonorDetails(widget.id),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data;
              // print(data);
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          padding: EdgeInsets.only(left: 20, bottom: 12),
                          decoration: BoxDecoration(
                              boxShadow: shadows1,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
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
                                  FontAwesomeIcons.locationDot,
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
                          width: double.infinity,
                          padding: EdgeInsets.only(bottom: 10, left: 15),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)), gradient: LinearGradient(colors: [colors.primary, colors.secondary])),
                          child: Flexible(
                            child: SelectableText(
                              data['full_name'],
                              style: texts.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: colors.onSecondary),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 10,
                          child: IconButton(
                              color: colors.inversePrimary,
                              icon: Icon(
                                Icons.arrow_back_ios,
                              ),
                              onPressed: () => Navigator.pop(context)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
                    child: TabBarView(
                      children: [
                        ContactsTab(
                          data: data,
                        ),
                        AddressTab(data: data),
                        Icon(Icons.directions_bike),
                        Icon(Icons.directions_bike),
                      ],
                    ),
                  ),
                ],
              );
            }
            return ConnectLottie();
          },
        ),
      ),
    );
  }
}
