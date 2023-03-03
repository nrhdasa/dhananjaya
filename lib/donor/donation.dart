import 'package:flutter/material.dart';

import '../resources/connectLottie.dart';
import '../resources/utils.dart';
import 'connection.dart';

class DonationTab extends StatelessWidget {
  final Map data;
  const DonationTab({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
    "Donation History",
    style: texts.labelLarge!.copyWith(color: colors.onBackground),
      ),
      const SizedBox(
    height: 20,
      ),
      SizedBox(
      height: MediaQuery.of(context).size.height * .60,
      child: FutureBuilder(
        future: getDonations(data['name']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<dynamic> donation = snapshot.data ?? [];
            return ListView.builder(
                itemCount: donation.length,
                itemBuilder: (BuildContext context, int index) {
                  // Text(donation[index]['name']),
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.centerLeft,
                              children: [
                                Positioned(
                                  child: SizedBox(
                                      height: 120,
                                      child: VerticalDivider(
                                        color: colors.primary,
                                        thickness: 2,
                                      )),
                                ),
                                Positioned(
                                  left: 2.5,
                                  // left: MediaQuery.of(context).size.width * .2,
                                  // width: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: colors.onBackground),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(getDateinFormat(donation[index]['receipt_date'], "yyyy"), style: const TextStyle(fontWeight: FontWeight.bold)),
                                          Text(getDateinFormat(donation[index]['receipt_date'], "MMM dd ")),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .85,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 50),
                                      width: 150,
                                      child: SizedBox(
                                        height: 90,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: colors.tertiaryContainer),
                                                        child: Icon(
                                                          Icons.domain,
                                                          color: colors.onTertiaryContainer,
                                                        )),
                                                    Text(donation[index]['company_abbreviation'])
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: colors.tertiaryContainer),
                                                        child: Icon(
                                                          Icons.payments_outlined,
                                                          color: colors.onTertiaryContainer,
                                                        )),
                                                    Text(donation[index]['payment_method'])
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: colors.tertiaryContainer),
                                                        child: Icon(
                                                          Icons.person_2_outlined,
                                                          color: colors.onTertiaryContainer,
                                                        )),
                                                    Text(donation[index]['preacher'])
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Towards",
                                                      style: TextStyle(fontSize: 10, color: colors.primary.withOpacity(.8)),
                                                    ),
                                                    SizedBox(
                                                        width: 100,
                                                        height: 20,
                                                        child: FittedBox(fit: BoxFit.fitHeight, child: Text(donation[index]['seva_type'] + "(" + donation[index]['seva_subtype'] + ")"))),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                        height: 60,
                                        child: VerticalDivider(
                                          thickness: 1,
                                          color: colors.primary,
                                        )),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        getStatus(donation[index]['workflow_state'], colors),
                                        SizedBox(
                                          width: 100,
                                          height: 60,
                                          child: FittedBox(
                                            alignment: Alignment.centerRight,
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              donation[index]['amount'].truncate().toString(),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "Ref.:" + donation[index]['name'],
                                          style: const TextStyle(fontSize: 8),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * .85,
                                  child: Divider(
                                    color: colors.onBackground,
                                    thickness: .5,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                });
          } else {
            return const ConnectLottie();
          }
        },
      ))
    ]);
  }

  Widget getStatus(status, colors) {
    Color bg, text;
    switch (status) {
      case "Draft":
        text = Colors.blue.shade900;
        bg = Colors.green.shade100;
        break;
      case "Realized":
        text = Colors.green.shade100;
        bg = Colors.green.shade900;
        break;
      default:
        text = colors.onPrimary;
        bg = colors.primary;
    }
    return Container(
      width: 70,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: bg, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)), shape: BoxShape.rectangle),
      child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            status,
            style: TextStyle(color: text),
          )),
    );
  }
}
