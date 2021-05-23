import 'package:avtokampi/layouts/add_camp_form.dart';
import 'package:avtokampi/layouts/camp_admins_list.dart';
import 'package:avtokampi/layouts/camp_reservation_form.dart';
import 'package:avtokampi/layouts/camps_map.dart';
import 'package:avtokampi/layouts/camp_home_screen.dart';
import 'package:avtokampi/layouts/kampi_web_view.dart';
import 'package:avtokampi/layouts/opinions_list.dart';
import 'package:avtokampi/layouts/profile_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
    HomeList({
        this.navigateScreen,
        this.imagePath = '',
    });

    Widget navigateScreen;
    String imagePath;

    static List<HomeList> homeList = [
        HomeList(
            imagePath: 'assets/images/kampi_ikona.png',
            navigateScreen: CampHomeScreen(),
        ),
        HomeList(
            imagePath: 'assets/images/rezerviraj_ikona.png',
            navigateScreen: ReservationForm(),
        ),
        HomeList(
            imagePath: 'assets/images/mnenja_ikona.png',
            navigateScreen: KampiList(),
        ),
        HomeList(
            imagePath: 'assets/images/mapa_ikona.png',
            navigateScreen: AvtokampiMap(),
        ),
        HomeList(
            imagePath: 'assets/images/user_ikona.png',
            navigateScreen: AppProfileHomeScreen(),
        ),
        HomeList(
            imagePath: 'assets/images/web.png',
            navigateScreen: KampiWeb(),
        ),
        HomeList(
            imagePath: 'assets/images/dodaj_ikona.png',
            navigateScreen: DodajKampForm(),
        ),
        HomeList(
            imagePath: 'assets/images/modify.png',
            navigateScreen: LastnikiKampovList(),
        ),
    ];
}
