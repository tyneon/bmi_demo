import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        fontFamily: GoogleFonts.inter().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff15192E),
          centerTitle: true,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xff15192E),
          indicatorColor: Color(0xff1D2136),
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w900,
          ),
          displaySmall: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  String currectPageLabel = "BMI calculator";

  @override
  Widget build(BuildContext context) {
    final pages = {
      "BMI calculator": BmiCalculatorPage(() {
        setState(() {
          currectPageLabel = "Result";
        });
      }),
      "Weight": const WeightPage(),
      "Result": const ResultPage(),
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(pages.keys.toList()[currentPageIndex]),
      ),
      body: pages[currectPageLabel],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            currectPageLabel = pages.keys.toList()[index];
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              "assets/calculator_icon.svg",
              colorFilter: const ColorFilter.mode(
                Color(0xff79BC99),
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset("assets/calculator_icon.svg"),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              "assets/stats_icon.svg",
              colorFilter: const ColorFilter.mode(
                Color(0xff79BC99),
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset("assets/stats_icon.svg"),
            label: '',
          ),
        ],
      ),
    );
  }
}
