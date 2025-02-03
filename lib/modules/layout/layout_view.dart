import 'package:evently_app_c13_mon_7pm/core/constants/app_assets.dart';
import 'package:evently_app_c13_mon_7pm/core/routes/page_routes_name.dart';
import 'package:evently_app_c13_mon_7pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_mon_7pm/main.dart';
import 'package:evently_app_c13_mon_7pm/models/bottom_nav_bar_model.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/favorite/favorite_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/home/home_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/map/map_view.dart';
import 'package:evently_app_c13_mon_7pm/modules/layout/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        label: AppLocalizations.of(navigatorKey.currentContext!)!.home,
        selectedIcn: AppAssets.selectedHome,
        unSelectedIcn: AppAssets.unSelectedHome),
    BottomNavBarModel(
        id: 1,
        label: AppLocalizations.of(navigatorKey.currentContext!)!.map,
        selectedIcn: AppAssets.selectedMap,
        unSelectedIcn: AppAssets.unSelectedMap),
    BottomNavBarModel(
        id: 2,
        label: AppLocalizations.of(navigatorKey.currentContext!)!.favorites,
        selectedIcn: AppAssets.selectedFavorite,
        unSelectedIcn: AppAssets.unSelectedFavorite),
    BottomNavBarModel(
        id: 3,
        label: AppLocalizations.of(navigatorKey.currentContext!)!.profile,
        selectedIcn: AppAssets.selectedProfile,
        unSelectedIcn: AppAssets.unSelectedProfile),
  ];

  List<Widget> screens = <Widget>[
    HomeView(),
    MapView(),
    FavoriteView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
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

          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                selectedIndex == 0
                    ? "assets/icons/selected_home_icn.png"
                    : "assets/icons/un_selected_home_icn.png",
              )),
              label: local.home,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                selectedIndex == 1
                    ? "assets/icons/selected_map_icn.png"
                    : "assets/icons/un_selected_map_icn.png",
              )),
              label: local.map,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                selectedIndex == 2
                    ? "assets/icons/selected_favorite_icn.png"
                    : "assets/icons/un_selected_favorite_icn.png",
              )),
              label: local.favorites,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                selectedIndex == 3
                    ? "assets/icons/selected_user_icn.png"
                    : "assets/icons/un_selected_user_icn.png",
              )),
              label: local.profile,
            ),
          ],
        ));
  }
}
