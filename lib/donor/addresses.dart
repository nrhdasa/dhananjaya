import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddressTab extends StatelessWidget {
  final Map data;
  const AddressTab({Key? key, required this.data}) : super(key: key);

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
                  "Address Details",
                  style: texts.labelLarge!.copyWith(color: colors.onBackground),
                ),
                SizedBox(
                  height: 20,
                ),
              ] +
              data['addresses'].map<Widget>((address) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 25,
                          width: 25,
                          child: Text(
                            address['type'][0].toUpperCase(),
                            style: texts.labelLarge!.copyWith(color: colors.onPrimary),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: colors.primary),
                        ),
                        Flexible(
                          child: SelectableText(
                            getAddressString(address),
                            style: texts.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    Divider()
                  ],
                );
              }).toList()),
    );
  }
}

// getAddressComp(var d){
//   if(d==)
// }

getAddressString(address) {
  if (address == null) {
    return "";
  } else {
    return address['address_line_1'] ?? "" + " " + address['address_line_2'] ?? "" + "," + address['city'] ?? "" + "," + address['state'] ?? "";
  }
}
