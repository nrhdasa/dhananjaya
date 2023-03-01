// import 'package:flutter/material.dart';

// import '../resources/connectLottie.dart';
// import '../resources/elements.dart';
// import 'connection.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class DonorPage extends StatefulWidget {
//   final String id;
//   const DonorPage({Key? key, required this.id}) : super(key: key);

//   @override
//   State<DonorPage> createState() => _DonorPageState();
// }

// class _DonorPageState extends State<DonorPage> {
//   @override
//   Widget build(BuildContext context) {
//     var colors = Theme.of(context).colorScheme;
//     var texts = Theme.of(context).textTheme;
//     return Scaffold(
//       body: FutureBuilder<dynamic>(
//         future: getDonorDetails(widget.id),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             var data = snapshot.data;
//             // print(data);
//             return Container(
//               height: MediaQuery.of(context).size.height,
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height * .4,
//                     decoration: BoxDecoration(color: colors.primaryContainer),
//                   ),
//                   Positioned(
//                       top: 100,
//                       child: Text(
//                         data['full_name'],
//                         style: texts.displaySmall!.copyWith(fontWeight: FontWeight.w600, color: colors.onPrimaryContainer),
//                       )),
//                   Positioned(
//                     top: 20,
//                     child: IconButton(
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                         ),
//                         onPressed: () => Navigator.pop(context)),
//                   ),
//                   Positioned(
//                     top: 200,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                             width: MediaQuery.of(context).size.width * .9,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(colors: [colors.background.withOpacity(.5), colors.primary.withOpacity(.3)]), boxShadow: shadows, borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                       Text(
//                                         "Contact Details",
//                                         style: texts.labelLarge!.copyWith(color: colors.onBackground),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ] +
//                                     data['contacts'].map<Widget>((contact) {
//                                       return Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 contact['contact_no'],
//                                                 style: texts.headlineSmall,
//                                               ),
//                                               Container(
//                                                 width: 150,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: Icon(Icons.call_outlined),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.whatsapp),
//                                                       style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.commentSms),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Divider()
//                                         ],
//                                       );
//                                     }).toList()),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                             width: MediaQuery.of(context).size.width * .9,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(colors: [colors.background.withOpacity(.5), colors.primary.withOpacity(.3)]), boxShadow: shadows, borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                       Text(
//                                         "Contact Details",
//                                         style: texts.labelLarge!.copyWith(color: colors.onBackground),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ] +
//                                     data['contacts'].map<Widget>((contact) {
//                                       return Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 contact['contact_no'],
//                                                 style: texts.headlineSmall,
//                                               ),
//                                               Container(
//                                                 width: 150,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: Icon(Icons.call_outlined),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.whatsapp),
//                                                       style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.commentSms),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Divider()
//                                         ],
//                                       );
//                                     }).toList()),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                             width: MediaQuery.of(context).size.width * .9,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(colors: [colors.background.withOpacity(.5), colors.primary.withOpacity(.3)]), boxShadow: shadows, borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                       Text(
//                                         "Contact Details",
//                                         style: texts.labelLarge!.copyWith(color: colors.onBackground),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ] +
//                                     data['contacts'].map<Widget>((contact) {
//                                       return Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 contact['contact_no'],
//                                                 style: texts.headlineSmall,
//                                               ),
//                                               Container(
//                                                 width: 150,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: Icon(Icons.call_outlined),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.whatsapp),
//                                                       style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.commentSms),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Divider()
//                                         ],
//                                       );
//                                     }).toList()),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                             width: MediaQuery.of(context).size.width * .9,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(colors: [colors.background.withOpacity(.5), colors.primary.withOpacity(.3)]), boxShadow: shadows, borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                       Text(
//                                         "Contact Details",
//                                         style: texts.labelLarge!.copyWith(color: colors.onBackground),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ] +
//                                     data['contacts'].map<Widget>((contact) {
//                                       return Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 contact['contact_no'],
//                                                 style: texts.headlineSmall,
//                                               ),
//                                               Container(
//                                                 width: 150,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: Icon(Icons.call_outlined),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.whatsapp),
//                                                       style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.commentSms),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Divider()
//                                         ],
//                                       );
//                                     }).toList()),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                             width: MediaQuery.of(context).size.width * .9,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(colors: [colors.background.withOpacity(.5), colors.primary.withOpacity(.3)]), boxShadow: shadows, borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                       Text(
//                                         "Contact Details",
//                                         style: texts.labelLarge!.copyWith(color: colors.onBackground),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ] +
//                                     data['contacts'].map<Widget>((contact) {
//                                       return Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 contact['contact_no'],
//                                                 style: texts.headlineSmall,
//                                               ),
//                                               Container(
//                                                 width: 150,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: Icon(Icons.call_outlined),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.whatsapp),
//                                                       style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.commentSms),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Divider()
//                                         ],
//                                       );
//                                     }).toList()),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                             width: MediaQuery.of(context).size.width * .9,
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 gradient: LinearGradient(colors: [colors.background.withOpacity(.5), colors.primary.withOpacity(.3)]), boxShadow: shadows, borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                       Text(
//                                         "Contact Details",
//                                         style: texts.labelLarge!.copyWith(color: colors.onBackground),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ] +
//                                     data['contacts'].map<Widget>((contact) {
//                                       return Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                 contact['contact_no'],
//                                                 style: texts.headlineSmall,
//                                               ),
//                                               Container(
//                                                 width: 150,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: Icon(Icons.call_outlined),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onPrimary, backgroundColor: colors.primary),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.whatsapp),
//                                                       style: IconButton.styleFrom(foregroundColor: Colors.green, backgroundColor: colors.onBackground),
//                                                     ),
//                                                     IconButton(
//                                                       onPressed: () {},
//                                                       icon: FaIcon(FontAwesomeIcons.commentSms),
//                                                       style: IconButton.styleFrom(foregroundColor: colors.onTertiary, backgroundColor: colors.tertiary),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           Divider()
//                                         ],
//                                       );
//                                     }).toList()),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           }
//           return ConnectLottie();
//         },
//       ),
//     );
//   }
// }
