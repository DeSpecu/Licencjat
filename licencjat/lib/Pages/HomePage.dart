import 'package:flutter/material.dart';
import 'package:licencjat/Pages/OfertyPage.dart';
import 'package:licencjat/Pages/ProfilPage.dart';
import 'package:licencjat/Widgets/Dopasowanie.dart';
import 'package:licencjat/src/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}
class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final _bottomBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.list_sharp),
        label: "Oferty pracy",
        backgroundColor: Colors.pink),
    const BottomNavigationBarItem(icon: Icon(Icons.accessibility), label: 'Twoje dopasowanie'),
    const BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profil')
  ];

  @override
  Widget build(BuildContext context) {

return Consumer<ModelTheme>(builder: (context, ModelTheme themeNotifier, child){
      return Scaffold(

        body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {
              if (newIndex == 1)
                _selectedIndex = 2;
              else
                _selectedIndex = newIndex;
            });
          },
          children: [OfertyPage(),const ProfilPage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: _bottomBarItems,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              if (index != 1) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500), curve: Curves.ease);
              }
              else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Dopasowanie()));
              }
            }),
      );
    });
  }
}