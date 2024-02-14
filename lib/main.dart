import 'package:bloodpresureapp/form.dart';
import 'package:bloodpresureapp/info.dart';
import 'package:flutter/material.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;
  int currentSystolic = 0;
  int currentDiastolic = 0;

  void updateBPValues(int systolic, int diastolic) {
    setState(() {
      currentSystolic = systolic;
      currentDiastolic = diastolic;
      currentPageIndex = 1; // Navigate to InfoScreen automatically
    });
  }

  final List<String> pageTitles = [
    'Blood Pressure Monitor', // Title for the first page
    'Blood Pressure Info', // Title for the second page
  ];

  final int systolicValue = 120;
  final int diastolicValue = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            pageTitles[currentPageIndex],
            style: const TextStyle( // Appbar Tittle
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blueGrey, // AppBar color
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white), // Info Icon
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Image.asset('assets/chart.png'), // Chart Image
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.blueGrey,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              icon: Icon(Icons.info),
              label: 'Info',
            ),
          ],
        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: <Widget>[
            Card(
              shadowColor: Colors.transparent,
              margin: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: MyCustomForm(onCalculate: updateBPValues),
              ),
            ),
            Card(
              shadowColor: Colors.transparent,
              margin: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: InfoScreen(
                  key: ValueKey(
                      "$currentSystolic-$currentDiastolic"),
                  systolic: currentSystolic,
                  diastolic: currentDiastolic,
                ),
              ),
            ),
          ],
        ));
  }
}
