import 'package:avtokampi/app_theme.dart';
import 'package:avtokampi/layouts/camp_reservation_form.dart';
import 'package:avtokampi/layouts/drawer_user_controller.dart';
import 'package:avtokampi/layouts/home_screen.dart';
import 'package:avtokampi/layouts/camp_home_screen.dart';
import 'package:avtokampi/layouts/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'opinions_list.dart';

class NavigationHomeScreen extends StatefulWidget {
    @override
    _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
    Widget screenView;
    DrawerIndex drawerIndex;
    AnimationController sliderAnimationController;

    @override
    void initState() {
        drawerIndex = DrawerIndex.HOME;
        screenView = const MyHomePage();
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            color: AppTheme.nearlyWhite,
            child: SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                    backgroundColor: AppTheme.nearlyWhite,
                    body: DrawerUserController(
                        screenIndex: drawerIndex,
                        drawerWidth: MediaQuery
                            .of(context)
                            .size
                            .width * 0.75,
                        animationController: (
                            AnimationController animationController) {
                            sliderAnimationController = animationController;
                        },
                        onDrawerCall: (DrawerIndex drawerIndexdata) {
                            changeIndex(drawerIndexdata);
                        },
                        screenView: screenView,
                    ),
                ),
            ),
        );
    }

    void changeIndex(DrawerIndex drawerIndexdata) {
        if (drawerIndex != drawerIndexdata) {
            drawerIndex = drawerIndexdata;
            if (drawerIndex == DrawerIndex.HOME) {
                setState(() {
                    screenView = const MyHomePage();
                });
            } else if (drawerIndex == DrawerIndex.Help) {
                setState(() {
                    screenView = CampHomeScreen();
                });
            } else if (drawerIndex == DrawerIndex.FeedBack) {
                setState(() {
                    screenView = KampiList();
                });
            } else if (drawerIndex == DrawerIndex.Invite) {
                setState(() {
                    screenView = ReservationForm();
                });
            } else {
                setState(() {
                    showDialog(
                        context: context,
                        builder: (_) =>
                            NetworkGiffyDialog(
                                key: Key("Network"),
                                image: Image.network(
                                    "https://giffiles.alphacoders.com/208/208893.gif",
                                    fit: BoxFit.cover,
                                ),
                                entryAnimation: EntryAnimation.RIGHT,
                                buttonOkText: Text("Ok"),
                                buttonCancelText: Text("Nazaj"),
                                title: Text(
                                    'APPLIKACIJA ZA KAMPIRANJE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                ),
                                description: Text(
                                    'Aplikacija nudi pregled nad avtokampi, rezervacijo kampiranja, oddajo mnenj o kampih in ??e mnoge druge stvari.',
                                    textAlign: TextAlign.center,
                                ),
                                onOkButtonPressed: () {
                                    Navigator.pop(context);
                                    screenView = const MyHomePage();
                                },
                                onCancelButtonPressed: () {
                                    Navigator.pop(context);
                                    screenView = const MyHomePage();
                                },
                            ));
                });
            }
        }
    }
}
