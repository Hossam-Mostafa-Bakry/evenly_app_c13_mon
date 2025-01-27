import 'package:evently_app_c13_mon_7pm/core/constants/app_assets.dart';
import 'package:evently_app_c13_mon_7pm/core/routes/page_routes_name.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/models/bottom_nav_bar_model.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/favorite/favorite_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/home/home_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/map/map_view.dart';
import 'package:flutter/material.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selectedIndex = 0;

  List<BottomNavBarModel> bottomBanBarItemsList = [
    BottomNavBarModel(
        id: 0,
        label: "Home",
        selectedIcn: AppAssets.selectedHome,
        unSelectedIcn: AppAssets.unSelectedHome),
    BottomNavBarModel(
        id: 1,
        label: "Map",
        selectedIcn: AppAssets.selectedMap,
        unSelectedIcn: AppAssets.unSelectedMap),
    BottomNavBarModel(
        id: 2,
        label: "Favorite",
        selectedIcn: AppAssets.selectedFavorite,
        unSelectedIcn: AppAssets.unSelectedFavorite),
    BottomNavBarModel(
        id: 3,
        label: "Profile",
        selectedIcn: AppAssets.selectedProfile,
        unSelectedIcn: AppAssets.unSelectedProfile),
  ];

  List<Widget> screens = <Widget>[
    HomeView(),
    MapView(),
    FavoriteView(),
    PageView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, PageRoutesName.createNewEvent);
        },
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: ColorPalette.white,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: ColorPalette.primaryColor,
            child: Icon(
              Icons.add,
              size: 26,
              color: ColorPalette.white,
            ),
          ),
        ),
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: ColorPalette.primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorPalette.white,
          unselectedItemColor: ColorPalette.white,
          items: bottomBanBarItemsList.map(
            (item) {
              return BottomNavigationBarItem(
                label: item.label,
                activeIcon: ImageIcon(
                  AssetImage(
                    item.selectedIcn,
                  ),
                ),
                icon: ImageIcon(
                  AssetImage(
                    item.unSelectedIcn,
                  ),
                ),
              );
            },
          ).toList()),
    );
  }
}
