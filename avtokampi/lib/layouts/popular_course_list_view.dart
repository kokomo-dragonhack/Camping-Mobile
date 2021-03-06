import 'package:avtokampi/layouts/app_theme.dart';
import 'package:avtokampi/layouts/camp_list_data.dart';
import 'package:avtokampi/layouts/category_camping_space.dart';
import 'package:avtokampi/layouts/camp_info_screen.dart';
import 'package:avtokampi/main.dart';
import 'package:avtokampi/models/Avtokamp.dart';
import 'package:flutter/material.dart';

class PopularCourseListView extends StatefulWidget {
    const PopularCourseListView(
        {Key key, this.callBack, this.avtokamp, this.campListData})
        : super(key: key);

    final Function callBack;
    final Avtokamp avtokamp;
    final CampListData campListData;

    @override
    _PopularCourseListViewState createState() =>
        _PopularCourseListViewState(avtokamp, campListData);
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
    AnimationController animationController;
    List<Category> popularCourseList;
    Avtokamp avtokamp;
    CampListData campListData;


    _PopularCourseListViewState(this.avtokamp, this.campListData);

    @override
    void initState() {
        animationController = AnimationController(
            duration: const Duration(milliseconds: 2000), vsync: this);
        super.initState();
        popularCourseList = Category.getPopularniKampi(avtokamp, campListData);
    }

    Future<bool> getData() async {
        await Future<dynamic>.delayed(const Duration(milliseconds: 200));
        return true;
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FutureBuilder<bool>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (!snapshot.hasData) {
                        return const SizedBox();
                    } else {
                        return GridView(
                            padding: const EdgeInsets.all(8),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                                popularCourseList.length,
                                    (int index) {
                                    final int count = popularCourseList
                                        .length;
                                    final Animation<double> animation =
                                    Tween<double>(begin: 0.0, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: animationController,
                                            curve: Interval(
                                                (1 / count) * index, 1.0,
                                                curve: Curves.fastOutSlowIn),
                                        ),
                                    );
                                    animationController.forward();
                                    return CategoryView(
                                        callback: () {
                                            widget.callBack();
                                        },
                                        category: popularCourseList[index],
                                        animation: animation,
                                        animationController: animationController,
                                        avtokamp: popularCourseList[index]
                                            .avtokamp,
                                        campListData: popularCourseList[index]
                                            .campListData,
                                    );
                                },
                            ),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 32.0,
                                crossAxisSpacing: 32.0,
                                childAspectRatio: 0.8,
                            ),
                        );
                    }
                },
            ),
        );
    }
}

class CategoryView extends StatelessWidget {
    const CategoryView({Key key,
        this.category,
        this.animationController,
        this.animation,
        this.callback, this.avtokamp, this.campListData})
        : super(key: key);

    final VoidCallback callback;
    final Category category;
    final AnimationController animationController;
    final Animation<dynamic> animation;
    final Avtokamp avtokamp;
    final CampListData campListData;

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
                        child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                                Navigator.push<dynamic>(context,
                                    MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            CourseInfoScreen(
                                                campListData, avtokamp)));
                            },
                            child: SizedBox(
                                height: 280,
                                child: Stack(
                                    alignment: AlignmentDirectional
                                        .bottomCenter,
                                    children: <Widget>[
                                        Container(
                                            child: Column(
                                                children: <Widget>[
                                                    Expanded(
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                color: HexColor(
                                                                    '#F8FAFB'),
                                                                borderRadius: const BorderRadius
                                                                    .all(
                                                                    Radius
                                                                        .circular(
                                                                        16.0)),
                                                                // border: new Border.all(
                                                                //     color: CampInfoAppTheme.notWhite),
                                                            ),
                                                            child: Column(
                                                                children: <
                                                                    Widget>[
                                                                    Expanded(
                                                                        child: Container(
                                                                            child: Column(
                                                                                children: <
                                                                                    Widget>[
                                                                                    Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .only(
                                                                                            top: 16,
                                                                                            left: 16,
                                                                                            right: 16),
                                                                                        child: Text(
                                                                                            category
                                                                                                .title,
                                                                                            textAlign: TextAlign
                                                                                                .left,
                                                                                            style: TextStyle(
                                                                                                fontWeight: FontWeight
                                                                                                    .w600,
                                                                                                fontSize: 16,
                                                                                                letterSpacing: 0.27,
                                                                                                color: CampInfoAppTheme
                                                                                                    .darkerText,
                                                                                            ),
                                                                                        ),
                                                                                    ),
                                                                                    Padding(
                                                                                        padding: const EdgeInsets
                                                                                            .only(
                                                                                            top: 8,
                                                                                            left: 16,
                                                                                            right: 16,
                                                                                            bottom: 8),
                                                                                        child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment
                                                                                                .spaceBetween,
                                                                                            crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .center,
                                                                                            children: <
                                                                                                Widget>[
                                                                                                Text(
                                                                                                    'Kraj: ${category
                                                                                                        .lessonCount}',
                                                                                                    textAlign: TextAlign
                                                                                                        .left,
                                                                                                    style: TextStyle(
                                                                                                        fontWeight: FontWeight
                                                                                                            .w200,
                                                                                                        fontSize: 12,
                                                                                                        letterSpacing: 0.27,
                                                                                                        color: CampInfoAppTheme
                                                                                                            .grey,
                                                                                                    ),
                                                                                                ),
                                                                                            ],
                                                                                        ),
                                                                                    ),
                                                                                ],
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width: 48,
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                    const SizedBox(
                                                        height: 48,
                                                    ),
                                                ],
                                            ),
                                        ),
                                        Container(
                                            child: Padding(
                                                padding:
                                                const EdgeInsets.only(top: 24,
                                                    right: 16,
                                                    left: 16),
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                16.0)),
                                                        boxShadow: <BoxShadow>[
                                                            BoxShadow(
                                                                color: CampInfoAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                    0.2),
                                                                offset: const Offset(
                                                                    0.0, 0.0),
                                                                blurRadius: 6.0),
                                                        ],
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                16.0)),
                                                        child: AspectRatio(
                                                            aspectRatio: 1.28,
                                                            child: Image.memory(
                                                                category
                                                                    .blobSlika)),
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    ),
                );
            },
        );
    }
}
