import 'package:digitalt_application/Layouts/BaseAppBar.dart';
import 'package:digitalt_application/Layouts/BaseAppDrawer.dart';
import 'package:digitalt_application/Layouts/BaseBottomAppBar.dart';
import 'package:flutter/material.dart';

/**
 * this is the infopage. it consists of information about digi-talt.no and
 * contact inofrmation
 */
class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

List<Widget> containers = [
  Container(
      child: SingleChildScrollView(
          child: Stack(children: [
    Center(
      child: Container(
        width: 800,
        child: Material(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2.0, color: Colors.grey)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Om Digi-talt',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //this is the title
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 400,
                child: Image(
                  image: AssetImage('assets/images/1.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //in this row you find author and published date
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2.0, color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.person),
                    Text('author'),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.date_range),
                    Text('date')
                  ],
                ),
              ),

              //this is the description of the case. the main text
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                    'For 3 ??r siden kunne jeg ikke sett for meg at jeg kom til ?? sitte 2 timer ?? gr??te p?? grunn av en 5er i norsk. 5 i norsk var helt uoppn??elig for meg p?? den tiden. Men etter hvert som jeg begynte ?? skrive og lese, fant jeg fort ut at dette var meg. Endelig fant jeg noe JEG var god p??. Noe jeg kunne bedre enn de andre. Og denne gaven har jeg tatt godt vare p??.Karakteren min i norsk gikk opp fra 3 til 4 og fra 4 til 5, og i ??r var ??ret jeg skulle f?? 6. Alle innleveringene mine har jeg f??tt h??yeste score p??, og alt ser utrolig lovende ut. Men en dag tar l??reren meg til side. Hun sp??r meg hvorfor jeg ikke er muntlig i timene. Jeg svarer som sant er, at jeg ikke liker ?? snakke h??yt i klasserommet. Jeg er utrolig ukomfortabel med klassen min, og jeg har mange ganger v??rt n??r ?? besvime n??r jeg har blitt tvunget til ?? snakke. Jeg forklarer henne situasjonen og hun sier at hun skal ta meg ut p?? gangen ?? snakke med meg for ?? kunne gi meg en muntlig karakter.Noe av det siste hun sa til meg, og noe av det som klistret seg mest fast til meg, var at jeg var en 6er i norsk. Jeg hadde endelig klart noe jeg ogs??. En av mine f??rste 6ere. Hun sier ingenting om at jeg m?? bli bedre til ?? snakke h??yt i klasserommet, fordi de faglige diskusjonene skulle jeg jo ta p?? gangen.Timene gikk og karakterene ble satt. 5. Der fikk jeg den i fleisen. Der hadde hun st??tt og sagt at jeg var en 6er, siden hun skulle respektere at jeg ikke klarte ?? snakke h??yt i klassen. Men s?? var grunnen til at jeg ikke var oppn??elig nok for en 6er, at jeg ikke var muntlig i timene.Det er sikkert teit og gr??te over en 5er. Men n??r du allerede har f??tt h??rt av l??reren din at du skal f?? 6er, men s?? trekker hun den tilbake p?? grunn av en psykisk lidelse, er det faen ikke greit. Og det gj??r det ikke noe bedre n??r de som ikke engang vet hva dobbeltkonsonant er, f??r utlevert en 5er de ogs??.S?? der gikk talentet mitt bort. Skriving regnes ikke lenger som noe jeg er god p??. I hvert fall ikke n??r hvem som helst klarer ?? f?? samme karakter som meg, bare fordi de har dumme sp??rsm??l n??r det gjelder verb.S?? takk til norskl??reren som gjorde meg enda mer usikker p?? meg selv, og fikk angsten til ?? f??le seg veldig betydningsfull i livet mitt igjen. Vet virkelig ikke hvordan jeg skal klare ?? m??te opp til neste norsktime.'),
              )
            ],
          ),
        ),
      ),
    )
  ]))),
  Container(
      child: SingleChildScrollView(
          child: Stack(children: [
    Center(
      child: Container(
        width: 800,
        child: Material(
          borderRadius: BorderRadius.circular(35),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Image(
                  image: AssetImage('assets/images/4.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
              //this is the title
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(
                  'Kontakt oss',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //this is the description of the case. the main text
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Telefon: +4793456322')),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Email: eksempel@gmail.com')),
            ],
          ),
        ),
      ),
    )
  ]))),
];

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: BaseAppBar(
              title: Text('DIGI-TALT'),
              appBar: AppBar(),
              widgets: <Widget>[Icon(Icons.more_vert)],
            ),
            bottomSheet: TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  child: Text('Om Digi-talt'),
                ),
                Tab(
                  child: Text('Kontakt oss'),
                )
              ],
            ),
            bottomNavigationBar: BaseBottomAppBar(),
            //creates the menu in the appbar(drawer)
            drawer: BaseAppDrawer(),
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/2.jpg'),
                      fit: BoxFit.cover)),
              child: TabBarView(
                children: containers,
              ),
            )));
  }
}
