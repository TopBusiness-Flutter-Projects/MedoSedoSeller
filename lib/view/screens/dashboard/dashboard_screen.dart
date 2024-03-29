import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/helper/network_info.dart';
import 'package:medosedo_vendor/helper/notification_helper.dart';
import 'package:medosedo_vendor/localization/language_constrants.dart';
import 'package:medosedo_vendor/provider/order_provider.dart';
import 'package:medosedo_vendor/provider/profile_provider.dart';
import 'package:medosedo_vendor/utill/color_resources.dart';
import 'package:medosedo_vendor/utill/dimensions.dart';
import 'package:medosedo_vendor/utill/images.dart';
import 'package:medosedo_vendor/utill/styles.dart';
import 'package:medosedo_vendor/view/screens/home/home_page_screen.dart';
import 'package:medosedo_vendor/view/screens/menu/menu_screen.dart';
import 'package:medosedo_vendor/view/screens/order/order_screen.dart';
import 'package:medosedo_vendor/view/screens/refund/refund_screen.dart';

import '../home/webview_app.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getSellerInfo(context);
    _screens = [
      HomePageScreen(callback: () {
        setState(() {
          _setPage(1);
        });
      }),
      OrderScreen(),
      RefundScreen(),
    ];

    NetworkInfo.checkConnectivity(context);

    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage: ${message.data}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, false);
      Provider.of<OrderProvider>(context, listen: false)
          .getOrderList(context, 1, 'all');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: ${message.data}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return Scaffold(
            key: _scaffoldKey,
            bottomNavigationBar: profile.userInfoModel == null
                ? null
                : BottomNavigationBar(
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: ColorResources.HINT_TEXT_COLOR,
                    selectedFontSize: Dimensions.FONT_SIZE_SMALL,
                    unselectedFontSize: Dimensions.FONT_SIZE_SMALL,
                    selectedLabelStyle: robotoBold,
                    showUnselectedLabels: true,
                    currentIndex: _pageIndex,
                    type: BottomNavigationBarType.fixed,
                    items: profile.userInfoModel?.isFactory == "1"
                        ? [
                            _barItem(
                                Images.home, getTranslated('home', context), 0),
                            _barItem(Images.order,
                                getTranslated('my_order', context), 1),
                            _barItem(Images.refund,
                                getTranslated('refund', context), 2),
                            _barItem(
                                Images.menu, getTranslated('menu', context), 3),
                          ]
                        : [
                            _barItem(
                                Images.home, getTranslated('home', context), 0),
                            _barItem(Images.order,
                                getTranslated('my_order', context), 1),
                            _barItem(Images.refund,
                                getTranslated('refund', context), 2),
                            _barItem(Images.shop_product, 'تسوق الان', 3),
                            _barItem(
                                Images.menu, getTranslated('menu', context), 4),
                          ],
                    onTap: (int index) {
                      if (profile.userInfoModel?.isFactory == "1") {
                        if (index == 3) {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (con) => MenuBottomSheet());
                        } else {
                          setState(() {
                            _setPage(index);
                          });
                        }
                      } else {
                        if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebViewApplicationSeller()));
                        } else if (index == 4) {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (con) => MenuBottomSheet());
                        } else {
                          setState(() {
                            _setPage(index);
                          });
                        }
                      }
                    },
                  ),
            body: PageView.builder(
              controller: _pageController,
              itemCount: _screens.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _screens[index];
              },
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding:
            const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                width: index == _pageIndex
                    ? Dimensions.ICON_SIZE_LARGE
                    : Dimensions.ICON_SIZE_MEDIUM,
                child: Image.asset(
                  icon,
                  color: index == _pageIndex
                      ? Theme.of(context).primaryColor
                      : ColorResources.HINT_TEXT_COLOR,
                )),
          ],
        ),
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
