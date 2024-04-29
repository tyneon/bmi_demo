import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bmi_demo/bmi_calculator_page.dart';
import 'package:bmi_demo/result_page.dart';
import 'package:bmi_demo/weight_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          background: Color(0xff1D2136),
          onBackground: Colors.white,
          primary: Colors.white,
          onPrimary: Color(0xff15192E),
          surface: Color(0xff323244),
          onSurface: Colors.white,
          secondary: Color(0xffBD4966),
          onSecondary: Colors.white,
          tertiary: Color(0xff79BC99),
          onTertiary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
        ),
        // textTheme: GoogleFonts.interTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff15192E),
          centerTitle: true,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xff1D2136),
          indicatorColor: Colors.white,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

final pages = {
  "BMI calculator": const BmiCalculatorPage(),
  "Weight": const WeightPage(),
  "Result": const ResultPage(),
};

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages.keys.toList()[currentPageIndex]),
      ),
      body: pages[pages.keys.toList()[currentPageIndex]],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.calculate),
            icon: Icon(Icons.calculate_outlined),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bar_chart),
            icon: Icon(Icons.bar_chart_outlined),
            label: '',
          ),
        ],
      ),
    );
  }
}
