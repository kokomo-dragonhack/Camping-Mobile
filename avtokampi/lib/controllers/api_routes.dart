class ApiRoutes {
    static const LOGIN = 'https://camping-api.azurewebsites.net/api/Auth/login';
    static const REGISTER = 'https://camping-api.azurewebsites.net/api/Auth/register';

    static const AVTOKAMPI = 'https://camping-api.azurewebsites.net/api/Avtokampi';
    static const AVTOKAMP = 'https://camping-api.azurewebsites.net/api/Avtokampi/%s';
    static const AVTOKAMP_SLIKE = 'https://camping-api.azurewebsites.net/api/Avtokampi/%s/slike';
    static const AVTOKAMP_SLIKA = 'https://camping-api.azurewebsites.net/api/Avtokampi/%s/slika';
    static const SLIKA_UREDI = 'https://camping-api.azurewebsites.net/api/Avtokampi/%s';
    static const SLIKA_BRISI = 'https://camping-api.azurewebsites.net/api/Avtokampi/%s/slika';
    static const REGIJE = 'https://camping-api.azurewebsites.net/api/Avtokampi/regije';
    static const DRZAVE = 'https://camping-api.azurewebsites.net/api/Avtokampi/drzave';
    static const CENIKI_ZA_KAMP = 'https://camping-api.azurewebsites.net/api/Avtokampi/%s/ceniki';
    static const CENIK_PODROBNOSTI = 'https://camping-api.azurewebsites.net/api/Avtokampi/%s/cenik';

    static const KAMPIRNA_MESTA_SEZNAM = 'https://camping-api.azurewebsites.net/api/KampirnaMesta/%s/avtokamp';
    static const KAMPIRNA_MESTA_PODATKI = 'https://camping-api.azurewebsites.net/api/KampirnaMesta/%s';
    static const KAMPIRNA_MESTA_NOVO = 'https://camping-api.azurewebsites.net/api/KampirnaMesta/%s';
    static const KAMPIRNA_MESTA_UREDI_BRISI = 'https://camping-api.azurewebsites.net/api/KampirnaMesta/%s/%s';
    static const KAMPIRNA_MESTA_KATEGORIJE = 'https://camping-api.azurewebsites.net/api/KampirnaMesta/kategorije';
    static const KAMPIRNA_MESTA_STORITVE = 'https://camping-api.azurewebsites.net/api/%s/KampirnoMesto';
    static const KAMPIRNA_MESTA_STORITVE_DODAJANJE = 'https://camping-api.azurewebsites.net/api/StoritveKampa/%s/KampirnoMesto';

    static const REZERVACIJE = 'https://camping-api.azurewebsites.net/api/Rezervacije/%s/uporabnik';
    static const REZERVACIJE_DODAJ = 'https://camping-api.azurewebsites.net/api/Rezervacije';
    static const REZERVACIJE_VRSTA_KAMPIRANJA = 'https://camping-api.azurewebsites.net/api/Rezervacije/vrsta_kampiranja';
    static const REZERVACIJE_STATUSI = 'https://camping-api.azurewebsites.net/api/Rezervacije/status';

    static const STORITVE = 'https://camping-api.azurewebsites.net/api/StoritveKampa';
    static const STORITVE_KAMPA = 'https://camping-api.azurewebsites.net/api/StoritveKampa/%s/avtokamp';
    static const STORITVE_KAMPA_KATEGORIJE = 'https://camping-api.azurewebsites.net/api/StoritveKampa/kategorije';

    static const UPORABNIKI = 'https://camping-api.azurewebsites.net/api/Uporabniki/%s';
    static const UPORABNIKI_PO_IMENU = 'https://camping-api.azurewebsites.net/api/Uporabniki/%s/username';
    static const UPORABNIKI_MNENJA_ZA_KAMP = 'https://camping-api.azurewebsites.net/api/Uporabniki/avtokamp/%s/mnenja';
    static const UPORABNIKI_MNENJA = 'https://camping-api.azurewebsites.net/api/Uporabniki/%s/mnenja';
    static const UPORABNIKI_MNENJE = 'https://camping-api.azurewebsites.net/api/Uporabniki/%s/mnenje';
}
