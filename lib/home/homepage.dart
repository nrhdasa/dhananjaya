import 'package:dhananjaya/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'apipage.dart';
import 'analysis.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var profile;
  int selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[Dashboard(), AnalysisPage(), Apipage()];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    var texts = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'API',
          ),
        ],
      ),
    );
  }
}
