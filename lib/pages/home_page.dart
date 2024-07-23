import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sabzi_mobile/components/menu_popup_text_button.dart';
import 'package:sabzi_mobile/models/neighborhood_model.dart';
import 'package:uicons/uicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NeighborhoodModel>(
          builder: (context, value, child) => MenuPopupTextButton(
            title: value.currentNeighborHood ?? "Add neighborhood",
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            items: const [
              {'label': 'Yunusobod', 'code': 'YUN'},
              {'label': 'Uchtepa', 'code': 'UCH'},
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                // visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                size: 26,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        showUnselectedLabels: true,
        currentIndex: _currentBottomNavigationIndex,
        useLegacyColorScheme: true,
        iconSize: 22,
        onTap: (value) {
          _currentBottomNavigationIndex = value;
          setState(() {});
          print(value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(UIcons.regularRounded.home),
            activeIcon: Icon(UIcons.solidRounded.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(UIcons.regularRounded.search),
            activeIcon: Icon(UIcons.boldRounded.search),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(UIcons.regularRounded.comments),
            activeIcon: Icon(UIcons.solidRounded.comments),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(UIcons.regularRounded.user),
            activeIcon: Icon(UIcons.solidRounded.user),
          ),
        ],
      ),
    );
  }
}
