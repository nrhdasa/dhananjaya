import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;

import 'addresses.dart';

class ContactsTab extends StatelessWidget {
  final Map data;
  const ContactsTab({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                    Text(
                      "Contact Details",
                      style: texts.labelLarge!.copyWith(color: colors.onBackground),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ] +
                  data['contacts'].map<Widget>((contact) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SelectableText(
                              contact['contact_no'],
                              style: texts.headlineSmall,
                            ),
                            SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // print("tel:"+contact['contact_no']);
                                      // ignore: prefer_interpolation_to_compose_strings
                                      urllauncher.launchUrl(Uri.parse("tel:" + contact['contact_no']));
                                    },
                                    icon: const Icon(Icons.call_outlined),
                                    style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      String c = contact['contact_no'].replaceAll(RegExp(r"\D"), "");
                                      try {
                                        c = "whatsapp://send?phone=/?phone=91${c.substring(c.length - 10)}";
                                        urllauncher.launchUrl(Uri.parse(c));
                                      // ignore: empty_catches
                                      } catch (e) {
                                      }
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.whatsapp),
                                    style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // ignore: prefer_interpolation_to_compose_strings
                                      urllauncher.launchUrl(Uri.parse("sms:" + contact['contact_no']));
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.commentSms),
                                    style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Divider()
                      ],
                    );
                  }).toList()),
          const SizedBox(height: 10,),
          AddressTab(data: data),
        ],
      ),
    );
  }
}
