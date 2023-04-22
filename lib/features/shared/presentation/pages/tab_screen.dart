import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:expatx/core/app_colors.dart';
import 'package:expatx/features/tabs/finances/presentation/pages/finance_screen.dart';
import 'package:expatx/features/tabs/history/presentation/pages/history_screen.dart';
import 'package:expatx/features/tabs/profile/presentation/pages/profile_screen.dart';

import '../../../tabs/feed/presentation/pages/feed_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // // Setting up OneSignal
  // Future<void> initPlatformState() async {
  //   //Remove this method to stop OneSignal Debugging
  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  //   OneSignal.shared.setAppId("e00d4c75-7ac6-4c3e-8589-9c124370b4fb");
  //   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //     // ignore: avoid_print
  //     print("Accepted permission: $accepted");
  //   });

  //   OneSignal.shared.setNotificationWillShowInForegroundHandler(
  //       (OSNotificationReceivedEvent event) {
  //     // Will be called whenever a notification is received in foreground
  //     // Display Notification, pass null param for not displaying the notification
  //     event.complete(event.notification);
  //   });

  //   OneSignal.shared
  //       .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //     // Will be called whenever a notification is opened/button pressed.
  //     // ignore: avoid_print
  //     print("notification opened handler");
  //   });

  //   OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
  //     // Will be called whenever the permission changes
  //     // (ie. user taps Allow on the permission prompt in iOS)
  //   });

  //   OneSignal.shared
  //       .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
  //     // Will be called whenever the subscription changes
  //     // (ie. user gets registered with OneSignal and gets a user ID)
  //   });

  //   OneSignal.shared.setEmailSubscriptionObserver(
  //       (OSEmailSubscriptionStateChanges emailChanges) {
  //     // Will be called whenever then user's email subscription changes
  //     // (ie. OneSignal.setEmail(email) is called and the user gets registered
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: AppColors.expatxFadedColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: false,
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const FeedScreen(),
      const HistoryScreen(),
      const FinanceScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        activeColorPrimary: AppColors.expatxPurple,
        inactiveColorPrimary: AppColors.expatxMediumGrey,
        iconSize: 40,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        // title: ("History"),
        activeColorPrimary: AppColors.expatxPurple,
        inactiveColorPrimary: AppColors.expatxMediumGrey,
        iconSize: 40,
        // routeAndNavigatorSettings: const RouteAndNavigatorSettings(
        //   initialRoute: "/work",
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.money_dollar),
        // title: ("Finances"),
        activeColorPrimary: AppColors.expatxPurple,
        inactiveColorPrimary: AppColors.expatxMediumGrey,
        iconSize: 40,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.profile_circled),
        // title: ("Profile"),
        activeColorPrimary: AppColors.expatxPurple,
        inactiveColorPrimary: AppColors.expatxMediumGrey,
        // textStyle: TextStyle()
        iconSize: 40,
      ),
    ];
  }
}
