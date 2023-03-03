import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;
import 'package:location/location.dart';

import 'connection.dart';

class AddressTab extends StatefulWidget {
  final Map data;
  const AddressTab({Key? key, required this.data}) : super(key: key);

  @override
  State<AddressTab> createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  bool locationUpdating = true;

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
                Text(
                  "Address Details",
                  style: texts.labelLarge!.copyWith(color: colors.onBackground),
                ),
                const SizedBox(
                  height: 20,
                ),
              ] +
              widget.data['addresses'].map<Widget>((address) {
                return InkWell(
                  radius: 10,
                  onTap: () {
                    // print(widget.data);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Location Details"),
                            content: SizedBox(
                              height: 70,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Longitude : ${address['longitude']}"), Text("Latitude : ${address['latitude']}")]),
                            ),
                            actions: [
                              locationUpdating
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          locationUpdating = false;
                                        });
                                        await updateLocation(address['name']);
                                        setState(() {
                                          locationUpdating = true;
                                        });
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text("Location is Updated."),
                                              );
                                            });
                                      },
                                      child: const Text("Update Location"))
                                  : Container(),
                              ElevatedButton(
                                  child: const Text("Go to Location"),
                                  onPressed: () {
                                    urllauncher.launchUrl(Uri.parse("https://www.google.com/maps/search/?api=1&query=${address['latitude']},${address['longitude']}"));
                                  })
                            ],
                          );
                        });
                  },
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: colors.primary),
                                  child: Text(
                                    address['type'][0].toUpperCase(),
                                    style: texts.labelLarge!.copyWith(color: colors.onPrimary),
                                  ),
                                ),
                                address['longitude'] != 0.0
                                    ? FaIcon(
                                        FontAwesomeIcons.checkDouble,
                                        color: colors.secondary,
                                      )
                                    : Container()
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 50,
                              height: 50,
                              child: SelectableText(
                                getAddressString(address),
                                style: const TextStyle(
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                );
              }).toList()),
    );
  }
}

updateLocation(String addressId) async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();
  print(locationData);

  updateLongLatAddress(addressId, locationData.longitude ?? 0.0, locationData.latitude ?? 0.0);
}

getAddressString(address) {
  if (address == null) {
    return "";
  } else {
    // ignore: prefer_adjacent_string_concatenation
    return address['address_line_1'] ?? "" + " " + address['address_line_2'] ?? "" + "," + address['city'] ?? "" + "," + address['state'] ?? "";
  }
}
