import 'package:flutter/material.dart';
import 'package:nome_na_lista/UI/myAccountPage.dart';
import 'package:nome_na_lista/UI/searchPage.dart';
import 'package:nome_na_lista/theme/style.dart';

class TabsPage extends StatefulWidget {
  int paramIndex;

  TabsPage({
    @required this.paramIndex,
  });

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController tabController;

  final tabs = [
    SearchPage(),
    MyAccountPage(),
  ];

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[widget.paramIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.paramIndex,
        backgroundColor: Color(0xff4f5b66),
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontFamily: "Poppins"),
        unselectedLabelStyle: TextStyle(fontFamily: "Poppins"),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            title: Text("Pesquisar Lista"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Perfil"),
          )
        ],
        onTap: (index) {
          setState(() {
            widget.paramIndex = index;
          });
        },
      ),
    );
  }
}
