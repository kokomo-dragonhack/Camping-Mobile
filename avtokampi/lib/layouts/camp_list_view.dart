import 'package:avtokampi/globals.dart' as globals;
import 'package:avtokampi/layouts/camp_list_app_theme.dart';
import 'package:avtokampi/layouts/camp_info_screen.dart';
import 'package:avtokampi/models/Mnenje.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'camp_list_data.dart';

class CampListView extends StatelessWidget {
    const CampListView({Key key,
        this.campData,
        this.animationController,
        this.animation,
        this.callback})
        : super(key: key);

    final VoidCallback callback;
    final CampListData campData;
    final AnimationController animationController;
    final Animation<dynamic> animation;

    Future<void> _ackAlert(BuildContext context, CampListData kamp) {
        if (globals.priljubljeniKampi.contains(kamp.titleTxt)) {
            return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('Priljubljene'),
                        content: const Text('Kamp je že med priljubljenimi.'),
                        actions: <Widget>[
                            FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                            ),
                        ],
                    );
                },
            );
        }
        globals.priljubljeniKampi.add(kamp.titleTxt);
        return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Priljubljene'),
                    content: const Text('Kamp dodan med priljubljene!'),
                    actions: <Widget>[
                        FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                );
            },
        );
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
                                .titleTxt} je že med priljubljenimi! Če ga želite odstraniti kliknite Odstrani.',
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
                    buttonCancelText: Text("Prekliči"),
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

    Future<void> showMnenja(BuildContext context, CampListData kamp) {
        String mnenjaTekst = "";
        if (kamp.mnenja.isNotEmpty) {
            int stMnenj = 0;
            for (Mnenje m in kamp.mnenja) {
                stMnenj++;
                mnenjaTekst += '$stMnenj: ${m.mnenje}\n';
            }
        } else {
            mnenjaTekst = "Ta kamp trenutno še nima mnenj";
        }
        return showDialog(
            context: context,
            builder: (_) =>
                NetworkGiffyDialog(
                    key: Key("Network"),
                    image: Image.network(
                        "https://www.animatedimages.org/data/media/630/animated-sms-and-text-message-image-0033.gif",
                        fit: BoxFit.cover,
                    ),
                    entryAnimation: EntryAnimation.BOTTOM,
                    buttonOkText: Text("Ok"),
                    buttonCancelText: Text("Nazaj"),
                    title: Text(
                        'MNENJA O KAMPU',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    description: Text(
                        mnenjaTekst,
                        textAlign: TextAlign.left,
                        maxLines: 5,
                    ),
                    onOkButtonPressed: () {
                        Navigator.of(context).pop();
                    },
                    onCancelButtonPressed: () {
                        Navigator.of(context).pop();
                    },
                ));
    }

    void moveTo(context) {
        Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    CourseInfoScreen(campData, campData.avtokamp),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
                return FadeTransition(
                    opacity: animation,
                    child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, 50 * (1.0 - animation.value), 0.0),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 16),
                            child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                    callback();
                                    moveTo(context);
                                },
                                onLongPress: () {
                                    showMnenja(context, campData);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.6),
                                                offset: const Offset(4, 4),
                                                blurRadius: 16,
                                            ),
                                        ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: Stack(
                                            children: <Widget>[
                                                Column(
                                                    children: <Widget>[
                                                        AspectRatio(
                                                            aspectRatio: 2,
                                                            child: Image.memory(
                                                                campData
                                                                    .imagePath,
                                                                fit: BoxFit
                                                                    .cover,
                                                            ),
                                                        ),
                                                        Container(
                                                            color: CampAppTheme
                                                                .buildLightTheme()
                                                                .backgroundColor,
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .start,
                                                                children: <
                                                                    Widget>[
                                                                    Expanded(
                                                                        child: Container(
                                                                            child: Padding(
                                                                                padding: const EdgeInsets
                                                                                    .only(
                                                                                    left: 16,
                                                                                    top: 8,
                                                                                    bottom: 8),
                                                                                child: Column(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment
                                                                                        .center,
                                                                                    crossAxisAlignment:
                                                                                    CrossAxisAlignment
                                                                                        .start,
                                                                                    children: <
                                                                                        Widget>[
                                                                                        Text(
                                                                                            campData
                                                                                                .titleTxt,
                                                                                            textAlign: TextAlign
                                                                                                .left,
                                                                                            style: TextStyle(
                                                                                                fontWeight: FontWeight
                                                                                                    .w600,
                                                                                                fontSize: 22,
                                                                                            ),
                                                                                        ),
                                                                                        Row(
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .center,
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                                .start,
                                                                                            children: <
                                                                                                Widget>[
                                                                                                Text(
                                                                                                    campData
                                                                                                        .subTxt,
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 14,
                                                                                                        color: Colors
                                                                                                            .grey
                                                                                                            .withOpacity(
                                                                                                            0.8)),
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                    width: 4,
                                                                                                ),
                                                                                                Icon(
                                                                                                    FontAwesomeIcons
                                                                                                        .mapMarkerAlt,
                                                                                                    size: 12,
                                                                                                    color: CampAppTheme
                                                                                                        .buildLightTheme()
                                                                                                        .primaryColor,
                                                                                                ),
                                                                                                Expanded(
                                                                                                    child: Text(
                                                                                                        '${campData
                                                                                                            .dist}',
                                                                                                        overflow:
                                                                                                        TextOverflow
                                                                                                            .ellipsis,
                                                                                                        style: TextStyle(
                                                                                                            fontSize: 14,
                                                                                                            color: Colors
                                                                                                                .grey
                                                                                                                .withOpacity(
                                                                                                                0.8)),
                                                                                                    ),
                                                                                                ),
                                                                                            ],
                                                                                        ),
                                                                                        Padding(
                                                                                            padding: const EdgeInsets
                                                                                                .only(
                                                                                                top: 4),
                                                                                            child: Row(
                                                                                                children: <
                                                                                                    Widget>[
                                                                                                    SmoothStarRating(
                                                                                                        allowHalfRating: true,
                                                                                                        spacing: 1,
                                                                                                        starCount: 5,
                                                                                                        rating: campData
                                                                                                            .rating,
                                                                                                        size: 20,
                                                                                                        color: CampAppTheme
                                                                                                            .buildLightTheme()
                                                                                                            .primaryColor,
                                                                                                        borderColor: CampAppTheme
                                                                                                            .buildLightTheme()
                                                                                                            .primaryColor,
                                                                                                    ),
                                                                                                    Text(
                                                                                                        '   Mnenj: ${campData
                                                                                                            .reviews
                                                                                                            .toString()}',
                                                                                                        style: TextStyle(
                                                                                                            fontSize: 14,
                                                                                                            color: Colors
                                                                                                                .grey
                                                                                                                .withOpacity(
                                                                                                                0.8)),
                                                                                                    ),
                                                                                                ],
                                                                                            ),
                                                                                        ),
                                                                                    ],
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right: 16,
                                                                            top: 8),
                                                                        child: Column(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .end,
                                                                            children: <
                                                                                Widget>[
                                                                                Text(
                                                                                    '\€${campData
                                                                                        .perNight}',
                                                                                    textAlign: TextAlign
                                                                                        .left,
                                                                                    style: TextStyle(
                                                                                        fontWeight: FontWeight
                                                                                            .w600,
                                                                                        fontSize: 22,
                                                                                    ),
                                                                                ),
                                                                                Text(
                                                                                    '/na noč',
                                                                                    style: TextStyle(
                                                                                        fontSize: 14,
                                                                                        color:
                                                                                        Colors
                                                                                            .grey
                                                                                            .withOpacity(
                                                                                            0.8)),
                                                                                ),
                                                                            ],
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                                Positioned(
                                                    top: 8,
                                                    right: 8,
                                                    child: Material(
                                                        color: Colors
                                                            .transparent,
                                                        child: InkWell(
                                                            borderRadius: const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    32.0),
                                                            ),
                                                            onTap: () {
                                                                _ackAlert2(
                                                                    context,
                                                                    campData);
                                                            },
                                                            child: Padding(
                                                                padding: const EdgeInsets
                                                                    .all(8.0),
                                                                child: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: CampAppTheme
                                                                        .buildLightTheme()
                                                                        .primaryColor,
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                )
                                            ],
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ),
                );
            },
        );
    }
}
