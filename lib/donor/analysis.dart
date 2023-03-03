import 'package:dhananjaya/resources/connectLottie.dart';
import 'package:flutter/material.dart';

import 'connection.dart';

class AnalysisTab extends StatelessWidget {
  final Map data;
  const AnalysisTab({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return FutureBuilder(
      future: getDonorStats(data['name']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Widget> lastYearDonations = [];
          List<Widget> totalDonations = [];
          List<dynamic> lastYearCompanies = snapshot.data!['last_year'];
          List<dynamic> totalCompanies = snapshot.data!['total'];

          for (var element in lastYearCompanies) {
            lastYearDonations.add(
              Column(
                children: [
                  Container(
                    // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: colors.tertiaryContainer, shape: BoxShape.rectangle),
                    child: Text(
                      "${(element['amount']!/100000).toStringAsFixed(2)} L",
                      style: texts.displaySmall!.copyWith(color: colors.onTertiaryContainer),
                    ),
                  ),
                  Text(
                    element['company'],
                    style: texts.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              )
            );
           }
           for (var element in totalCompanies) {
            totalDonations.add(
              Column(
                children: [
                  Container(
                    // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: colors.tertiaryContainer, shape: BoxShape.rectangle),
                    child: Text(
                      "${(element['amount']!/100000).toStringAsFixed(2)} L",
                      style: texts.displaySmall!.copyWith(color: colors.onTertiaryContainer),
                    ),
                  ),
                  Text(
                    element['company'],
                    style: texts.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              )
            );
           }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: lastYearDonations,),
                Text(
                  "DONATIONS LAST YEAR",
                  style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: colors.secondary),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: totalDonations,),
                Text(
                  "DONATIONS BY NOW",
                  style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: colors.secondary),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        } else {
          return const ConnectLottie();
        }
      },
    );
  }
}
