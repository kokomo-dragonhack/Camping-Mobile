import 'dart:convert';
import 'dart:typed_data';

import 'package:avtokampi/globals.dart' as globals;
import 'package:avtokampi/layouts/camp_list_data.dart';
import 'package:avtokampi/layouts/camp_map.dart';
import 'package:avtokampi/models/Avtokamp.dart';
import 'package:avtokampi/models/KampirnoMesto.dart';
import 'package:avtokampi/models/Slika.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'app_theme.dart';
import 'home_design_course.dart';

class CourseInfoScreen extends StatefulWidget {

    CampListData avtokampElement;
    Avtokamp avtokamp;

    CourseInfoScreen(this.avtokampElement, this.avtokamp);

    @override
    _CourseInfoScreenState createState() =>
        _CourseInfoScreenState.avtokamp(avtokamp, avtokampElement);
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {

    final double infoHeight = 364.0;
    AnimationController animationController;
    Animation<double> animation;
    double opacity1 = 0.0;
    double opacity2 = 0.0;
    double opacity3 = 0.0;

    CampListData avtokampElement;
    Avtokamp avtokamp;
    List<Uint8List> slike = [];
    Image slika;
    int indeksSlike = 0;

    _CourseInfoScreenState();

    _CourseInfoScreenState.avtokamp(this.avtokamp, this.avtokampElement);

    int getStKampirnihMest() {
        int stMest = 0;
        for (KampirnoMesto km in globals.kampirnaMesta) {
            if (km.avtokamp == this.avtokamp.id) {
                stMest++;
            }
        }
        return stMest;
    }

    Future<void> _ackAlert2(BuildContext context, CampListData kamp) {
        if (globals.priljubljeniKampi.contains(kamp.titleTxt)) {
            return showDialog(
                context: context,
                builder: (_) =>
                    NetworkGiffyDialog(
                        key: Key("Network"),
                        image: Image.network(
                            "https://i.pinimg.com/originals/99/82/e7/9982e7c21b0934a65f5ddb36bd0a9656.gif",
                            fit: BoxFit.cover,
                        ),
                        entryAnimation: EntryAnimation.TOP_LEFT,
                        buttonOkText: Text("Ok"),
                        buttonCancelText: Text("Odstrani"),
                        title: Text(
                            'PRILJUBLJENE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600),
                        ),
                        description: Text(
                            'Kamp ${kamp
                                .titleTxt} je ??e med priljubljenimi! ??e ga ??elite odstraniti kliknite Odstrani.',
                            textAlign: TextAlign.center,
                        ),
                        onOkButtonPressed: () {
                            Navigator.of(context).pop();
                        },
                        onCancelButtonPressed: () {
                            globals.priljubljeniKampi.remove(kamp.titleTxt);
                            Navigator.of(context).pop();
                        },
                    ));
        }
        return showDialog(
            context: context,
            builder: (_) =>
                NetworkGiffyDialog(
                    key: Key("Network"),
                    image: Image.network(
                        "https://i.pinimg.com/originals/99/82/e7/9982e7c21b0934a65f5ddb36bd0a9656.gif",
                        fit: BoxFit.cover,
                    ),
                    entryAnimation: EntryAnimation.TOP_LEFT,
                    buttonOkText: Text("Ok"),
                    buttonCancelText: Text("Prekli??i"),
                    title: Text(
                        'PRILJUBLJENE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    description: Text(
                        'S klikom na Ok bo kamp ${kamp
                            .titleTxt} dodan med priljubljene!',
                        textAlign: TextAlign.center,
                    ),
                    onOkButtonPressed: () {
                        globals.priljubljeniKampi.add(kamp.titleTxt);
                        Navigator.of(context).pop();
                    },
                    onCancelButtonPressed: () {
                        Navigator.of(context).pop();
                    },
                ));
    }

    List<Uint8List> getSlikeZaKamp(int kampId) {
        List<Uint8List> slike = [];
        for (Slika slika in globals.slike) {
            if (slika.avtokamp == kampId) {
                slike.add(base64Decode(slika.slika));
            }
        }
        if (slike.isEmpty) {
            slike.add(base64Decode(globals.slike[0].slika));
        }
        return slike;
    }

    @override
    void initState() {
        animationController = AnimationController(
            duration: const Duration(milliseconds: 1000), vsync: this);
        animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
        setData();
        slika = Image.memory(avtokampElement.imagePath);
        slike = getSlikeZaKamp(avtokamp.id);
        super.initState();
    }

    Future<void> setData() async {
        animationController.forward();
        await Future<dynamic>.delayed(const Duration(milliseconds: 200));
        setState(() {
            opacity1 = 1.0;
        });
        await Future<dynamic>.delayed(const Duration(milliseconds: 200));
        setState(() {
            opacity2 = 1.0;
        });
        await Future<dynamic>.delayed(const Duration(milliseconds: 200));
        setState(() {
            opacity3 = 1.0;
        });
    }

    @override
    Widget build(BuildContext context) {
        final double tempHeight = MediaQuery
            .of(context)
            .size
            .height -
            (MediaQuery
                .of(context)
                .size
                .width / 1.2) +
            24.0;
        return Container(
            color: CampInfoAppTheme.nearlyWhite,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                    children: <Widget>[
                        Column(
                            children: <Widget>[
                                InkWell(child: AspectRatio(
                                    aspectRatio: 1.2,
                                    child: slika,
                                ),
                                    onTap: () {
                                        setState(() {
                                            if (slike.length > 1) {
                                                print("lalal");
                                                indeksSlike++;
                                                slika = Image.memory(
                                                    slike[indeksSlike %
                                                        slike.length]);
                                            }
                                        });
                                    },)
                            ],
                        ),
                        Positioned(
                            top: (MediaQuery
                                .of(context)
                                .size
                                .width / 1.2) - 24.0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: CampInfoAppTheme.nearlyWhite,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(32.0),
                                        topRight: Radius.circular(32.0)),
                                    boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: CampInfoAppTheme.grey
                                                .withOpacity(0.2),
                                            offset: const Offset(1.1, 1.1),
                                            blurRadius: 10.0),
                                    ],
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: SingleChildScrollView(
                                        child: Container(
                                            constraints: BoxConstraints(
                                                minHeight: infoHeight,
                                                maxHeight: tempHeight >
                                                    infoHeight
                                                    ? tempHeight
                                                    : infoHeight),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                    Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            top: 32.0,
                                                            left: 18,
                                                            right: 16),
                                                        child: Text(
                                                            "${avtokampElement
                                                                .titleTxt}\n${avtokamp
                                                                .naslov}",
                                                            textAlign: TextAlign
                                                                .left,
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                fontSize: 22,
                                                                letterSpacing: 0.27,
                                                                color: CampInfoAppTheme
                                                                    .darkerText,
                                                            ),
                                                        ),
                                                    ),
                                                    Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 16,
                                                            right: 16,
                                                            bottom: 8,
                                                            top: 16),
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .center,
                                                            children: <Widget>[
                                                                Text(
                                                                    '${avtokampElement
                                                                        .perNight
                                                                        .toString()}???/no??',
                                                                    textAlign: TextAlign
                                                                        .left,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .w200,
                                                                        fontSize: 17,
                                                                        letterSpacing: 0.27,
                                                                        color: CampInfoAppTheme
                                                                            .nearlyBlue,
                                                                    ),
                                                                ),
                                                                Container(
                                                                    child: Row(
                                                                        children: <
                                                                            Widget>[
                                                                            Text(
                                                                                avtokampElement
                                                                                    .rating
                                                                                    .toInt()
                                                                                    .toString(),
                                                                                textAlign: TextAlign
                                                                                    .left,
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight
                                                                                        .w200,
                                                                                    fontSize: 17,
                                                                                    letterSpacing: 0.27,
                                                                                    color: CampInfoAppTheme
                                                                                        .grey,
                                                                                ),
                                                                            ),
                                                                            Icon(
                                                                                Icons
                                                                                    .star,
                                                                                color: CampInfoAppTheme
                                                                                    .nearlyBlue,
                                                                                size: 18,
                                                                            ),
                                                                        ],
                                                                    ),
                                                                )
                                                            ],
                                                        ),
                                                    ),
                                                    AnimatedOpacity(
                                                        duration: const Duration(
                                                            milliseconds: 500),
                                                        opacity: opacity1,
                                                        child: Padding(
                                                            padding: const EdgeInsets
                                                                .all(4),
                                                            child: Row(
                                                                children: <
                                                                    Widget>[
                                                                    getTimeBoxUI(
                                                                        'Dr??ava',
                                                                        avtokampElement
                                                                            .dist
                                                                            .toString()),
                                                                    getTimeBoxUI(
                                                                        'Telefon',
                                                                        avtokamp
                                                                            .telefon
                                                                            .toString()),
                                                                    getTimeBoxUI(
                                                                        'Mesta',
                                                                        getStKampirnihMest()
                                                                            .toString()),
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                    Expanded(
                                                        child: AnimatedOpacity(
                                                            duration: const Duration(
                                                                milliseconds: 500),
                                                            opacity: opacity2,
                                                            child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 16,
                                                                    right: 16,
                                                                    top: 8,
                                                                    bottom: 8),
                                                                child: Text(
                                                                    avtokamp
                                                                        .opis,
                                                                    textAlign: TextAlign
                                                                        .justify,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .w200,
                                                                        fontSize: 14,
                                                                        letterSpacing: 0.27,
                                                                        color: CampInfoAppTheme
                                                                            .grey,
                                                                    ),
                                                                    maxLines: 8,
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                    AnimatedOpacity(
                                                        duration: const Duration(
                                                            milliseconds: 500),
                                                        opacity: opacity3,
                                                        child: Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                bottom: 16,
                                                                right: 16),
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .center,
                                                                children: <
                                                                    Widget>[
                                                                    Container(
                                                                        width: 48,
                                                                        height: 48,
                                                                        child: InkWell(
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: CampInfoAppTheme
                                                                                        .nearlyWhite,
                                                                                    borderRadius: const BorderRadius
                                                                                        .all(
                                                                                        Radius
                                                                                            .circular(
                                                                                            16.0),
                                                                                    ),
                                                                                    border: Border
                                                                                        .all(
                                                                                        color: CampInfoAppTheme
                                                                                            .grey
                                                                                            .withOpacity(
                                                                                            0.2)),
                                                                                ),
                                                                                child: Icon(
                                                                                    Icons
                                                                                        .location_on,
                                                                                    color: Colors
                                                                                        .red,
                                                                                    size: 28,
                                                                                ),
                                                                            ),
                                                                            onTap: () {
                                                                                Navigator
                                                                                    .push<
                                                                                    dynamic>(
                                                                                    context,
                                                                                    MaterialPageRoute<
                                                                                        dynamic>(
                                                                                        builder: (
                                                                                            BuildContext context) =>
                                                                                            AvtokampMap(
                                                                                                a: avtokamp,),
                                                                                    ),
                                                                                );
                                                                            },),
                                                                    ),
                                                                    const SizedBox(
                                                                        width: 16,
                                                                    ),
                                                                    Expanded(
                                                                        child: InkWell(
                                                                            child: Container(
                                                                                height: 48,
                                                                                decoration: BoxDecoration(
                                                                                    color: CampInfoAppTheme
                                                                                        .nearlyBlue,
                                                                                    borderRadius: const BorderRadius
                                                                                        .all(
                                                                                        Radius
                                                                                            .circular(
                                                                                            16.0),
                                                                                    ),
                                                                                    boxShadow: <
                                                                                        BoxShadow>[
                                                                                        BoxShadow(
                                                                                            color: CampInfoAppTheme
                                                                                                .nearlyBlue
                                                                                                .withOpacity(
                                                                                                0.5),
                                                                                            offset: const Offset(
                                                                                                1.1,
                                                                                                1.1),
                                                                                            blurRadius: 10.0),
                                                                                    ],
                                                                                ),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                        'REZERVIRAJ',
                                                                                        textAlign: TextAlign
                                                                                            .left,
                                                                                        style: TextStyle(
                                                                                            fontWeight: FontWeight
                                                                                                .w600,
                                                                                            fontSize: 18,
                                                                                            letterSpacing: 0.0,
                                                                                            color: CampInfoAppTheme
                                                                                                .nearlyWhite,
                                                                                        ),
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                            onTap: () {
                                                                                Navigator
                                                                                    .push<
                                                                                    dynamic>(
                                                                                    context,
                                                                                    MaterialPageRoute<
                                                                                        dynamic>(
                                                                                        builder: (
                                                                                            BuildContext context) =>
                                                                                            CampInfoHomeScreen(
                                                                                                avtokamp: avtokamp,
                                                                                                campListData: avtokampElement,),
                                                                                    ),
                                                                                );
                                                                            },),
                                                                    )
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                    SizedBox(
                                                        height: MediaQuery
                                                            .of(context)
                                                            .padding
                                                            .bottom,
                                                    )
                                                ],
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                        ),
                        Positioned(
                            top: (MediaQuery
                                .of(context)
                                .size
                                .width / 1.2) - 24.0 - 35,
                            right: 35,
                            child: ScaleTransition(
                                alignment: Alignment.center,
                                scale: CurvedAnimation(
                                    parent: animationController,
                                    curve: Curves.fastOutSlowIn),
                                child: Card(
                                    color: CampInfoAppTheme.nearlyBlue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50.0)),
                                    elevation: 10.0,
                                    child: InkWell(child: Container(
                                        width: 60,
                                        height: 60,
                                        child: Center(
                                            child: Icon(
                                                Icons.favorite,
                                                color: CampInfoAppTheme
                                                    .nearlyWhite,
                                                size: 30,
                                            ),
                                        ),
                                    ), onTap: () {
                                        _ackAlert2(context, avtokampElement);
                                    },),
                                ),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .padding
                                .top),
                            child: SizedBox(
                                width: AppBar().preferredSize.height,
                                height: AppBar().preferredSize.height,
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius:
                                        BorderRadius.circular(
                                            AppBar().preferredSize.height),
                                        child: Icon(
                                            Icons.arrow_back_ios,
                                            color: CampInfoAppTheme
                                                .nearlyBlack,
                                        ),
                                        onTap: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                ),
                            ),
                        )
                    ],
                ),
            ),
        );
    }

    Widget getTimeBoxUI(String text1, String txt2) {
        return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                decoration: BoxDecoration(
                    color: CampInfoAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: CampInfoAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 8.0),
                    ],
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Text(
                                text1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: CampInfoAppTheme.nearlyBlue,
                                ),
                            ),
                            Text(
                                txt2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: CampInfoAppTheme.grey,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
