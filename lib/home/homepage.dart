import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../connectivity.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var profile;
  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hare Krishna", style: texts.titleMedium),
                      FutureBuilder<dynamic>(
                        future: get_profile(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            print(snapshot.data);
                            return Text(
                              snapshot.data?['full_name'],
                              style: texts.headlineMedium,
                              overflow: TextOverflow.fade,
                            );
                          }
                          return Text("");
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          color: colors.primary,
                          onPressed: () {
                            context.go('/searchdonor');
                          },
                          icon: Icon(Icons.search)),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(color: colors.primary, onPressed: () {}, icon: Icon(Icons.logout)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              // Row(
              //   children: [
              //     // TextField(
              //     //   decoration: InputDecoration(label: Text("Search Donor")),
              //     // ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    ));
  }

  get_profile() async {
    var data = await Auth.getAPI();
    return data;
  }
}
