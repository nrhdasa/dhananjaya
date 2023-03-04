import 'dart:convert';

import 'package:dhananjaya/home/connection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;
import '../resources/connectLottie.dart';

class SearchDonor extends StatefulWidget {
  const SearchDonor({Key? key}) : super(key: key);

  @override
  State<SearchDonor> createState() => _SearchDonorState();
}

class _SearchDonorState extends State<SearchDonor> {
  var donors = [];
  bool _waiting = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return Hero(
      tag: "search-donor",
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * .13,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          autofocus: true,
                          controller: searchController,
                          style: Theme.of(context).textTheme.headlineLarge,
                          decoration: InputDecoration(

                              // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                              prefixIcon: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                  },
                                  icon: const Icon(Icons.cancel))),
                          onChanged: (val) async {
                            setState(() {
                              _waiting = true;
                            });
                            var data = await getDonors(val);
                            // print(data);
                            setState(() {
                              donors = data;
                              _waiting = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * .87,
                    child: _waiting
                        ? const ConnectLottie()
                        : Stack(
                            children: [
                              ListView.builder(
                                  itemCount: donors.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return DonorTile(donor: donors[index]);
                                  }),
                              Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                  colors.background,
                                  colors.background.withOpacity(0),
                                ])),
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [colors.background, colors.background.withOpacity(0)]),
                                    ),
                                  ))
                              // Container(
                              //   height: 30,
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [colors.background, colors.background.withOpacity(.2)])),
                              // ),
                            ],
                          ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class DonorTile extends StatelessWidget {
  final Map donor;
  const DonorTile({Key? key, required this.donor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    List<dynamic> adds = jsonDecode(donor['addresses']).toSet().toList();
    List<dynamic> contacts = jsonDecode(donor['contacts']).toSet().toList();
    if (contacts.length > 2) {
      contacts = contacts.sublist(0, 2);
    }

    Color textColor = donor['is_patron'] != 1 ? colors.onBackground : colors.onTertiaryContainer;
    return Card(
        shadowColor: colors.secondary,
        elevation: 4,
        surfaceTintColor: colors.onBackground,
        color: donor['is_patron'] != 1 ? colors.background : colors.tertiaryContainer,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            context.goNamed('donor', params: {"id": donor['name']});
          },
          child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .7,
                                  child: Text(
                                    donor['full_name'],
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor, fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: contacts.map((e) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                        onTap: () {
                                          urllauncher.launchUrl(Uri.parse("tel:$e"));
                                        },
                                        child: Text(
                                          e.toString(),
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              ] +
                              adds
                                  .map((e) => SizedBox(
                                        width: MediaQuery.of(context).size.width * .6,
                                        child: Text(
                                          e.toString(),
                                          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: textColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList()),
                      Container(
                        decoration: BoxDecoration(color: colors.tertiary, shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                        child: Text(
                          donor['initial'],
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: colors.onTertiary, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
