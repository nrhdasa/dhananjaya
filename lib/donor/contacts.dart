import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;

class ContactsTab extends StatelessWidget {
  final Map data;
  const ContactsTab({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
                Text(
                  "Contact Details",
                  style: texts.labelLarge!.copyWith(color: colors.onBackground),
                ),
                SizedBox(
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
                        Text(
                          contact['contact_no'],
                          style: texts.headlineSmall,
                        ),
                        Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.call_outlined),
                                style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
                              ),
                              IconButton(
                                onPressed: () {
                                  String c = contact['contact_no'].replaceAll(RegExp(r"\D"), "");
                                  try {
                                    c = "https://wa.me/91${c.substring(c.length - 10)}";
                                    print(c);
                                    urllauncher.launchUrl(Uri.parse(c));
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                icon: FaIcon(FontAwesomeIcons.whatsapp),
                                style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(FontAwesomeIcons.commentSms),
                                style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider()
                  ],
                );
              }).toList()),
    );
  }
}
