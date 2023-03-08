import 'dart:convert';

import 'package:dhananjaya/home/connection.dart';
import 'package:dhananjaya/search/filters_page.dart';
import 'package:dhananjaya/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;
import '../resources/connectLottie.dart';
import '../resources/utils.dart';
import 'package:easy_debounce/easy_debounce.dart';

class SearchDonor extends StatefulWidget {
  const SearchDonor({Key? key}) : super(key: key);

  @override
  State<SearchDonor> createState() => _SearchDonorState();
}

class _SearchDonorState extends State<SearchDonor> {
  // var donors = [];
  bool _waiting = false;
  TextEditingController searchController = TextEditingController();
  // final Debouncer onSearchDebouncer = new Debouncer(delay: new Duration(milliseconds: 200));

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return Hero(
      tag: "search-donor",
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: BlocProvider<SearchBloc>(
                create: (context) => SearchBloc(),
                child: BlocListener<SearchBloc, Map>(
                  child: BlocBuilder<SearchBloc, Map>(
                    builder: (context, donors) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * .13,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: TextField(
                                      autofocus: true,
                                      controller: searchController,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                      decoration: InputDecoration(
                                        prefixIcon: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              searchController.clear();
                                            },
                                            icon: const Icon(Icons.clear)),
                                      ),
                                      onChanged: (val) async {
                                        // context.read<SearchBloc>().setSearchQuery = val;
                                        EasyDebounce.debounce('search_query', Duration(milliseconds: 1000), () => context.read<SearchBloc>().add({'search': val}));
                                      }),
                                ),
                                Flexible(
                                    flex: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.filter_list),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) {
                                              return Stack(
                                                children: [
                                                  FilterPage(),
                                                  Positioned(
                                                      top: 1,
                                                      right: 2,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                            context.read<SearchBloc>().getDonors();
                                                          },
                                                          icon: Icon(
                                                            Icons.check,
                                                            size: 30,
                                                            color: Colors.green,
                                                          ))),
                                                ],
                                              );
                                            });
                                      },
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * .87,
                            child: donors['state'] == FetchingState.loading
                                ? const ConnectLottie()
                                : Stack(
                                    children: [
                                      ListView.builder(
                                          itemCount: donors['data'].length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return DonorTile(donor: donors['data'][index]);
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
                      );
                    },
                  ),
                  listener: (context, donors) {
                    if (donors['state'] == FetchingState.failed) {
                      showErrorDialog(context, donors['errorResponse']);
                    }
                  },
                ),
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
    List<dynamic> adds = donor['addresses'];
    List<dynamic> contacts = donor['contacts'];
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
                      Flexible(
                        flex: 1,
                        child: Column(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: contacts.map((e) {
                                      return Container(
                                        margin: EdgeInsets.only(right: 3),
                                        padding: EdgeInsets.only(left: 1, right: 1),
                                        decoration: BoxDecoration(
                                            color: colors.secondaryContainer, border: Border.all(width: .1), shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(5))),
                                        child: InkWell(
                                          onTap: () {
                                            urllauncher.launchUrl(Uri.parse("tel:$e"));
                                          },
                                          child: Text(
                                            e.toString(),
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: colors.onSecondaryContainer),
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
                      ),
                      Flexible(
                        flex: 0,
                        child: Container(
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(color: colors.tertiary, shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(10))),
                                padding: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                                child: Text(
                                  donor['llp_preacher'],
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: colors.onTertiary, fontWeight: FontWeight.bold),
                                ),
                              ),
                              donor['last_donation'] != null
                                  ? Container(
                                      width: 60,
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Icon(Icons.history),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(getDateinFormat(donor['last_donation'], "dd MMM,yy"))
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
