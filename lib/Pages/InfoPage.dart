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
                    'For 3 år siden kunne jeg ikke sett for meg at jeg kom til å sitte 2 timer å gråte på grunn av en 5er i norsk. 5 i norsk var helt uoppnåelig for meg på den tiden. Men etter hvert som jeg begynte å skrive og lese, fant jeg fort ut at dette var meg. Endelig fant jeg noe JEG var god på. Noe jeg kunne bedre enn de andre. Og denne gaven har jeg tatt godt vare på.Karakteren min i norsk gikk opp fra 3 til 4 og fra 4 til 5, og i år var året jeg skulle få 6. Alle innleveringene mine har jeg fått høyeste score på, og alt ser utrolig lovende ut. Men en dag tar læreren meg til side. Hun spør meg hvorfor jeg ikke er muntlig i timene. Jeg svarer som sant er, at jeg ikke liker å snakke høyt i klasserommet. Jeg er utrolig ukomfortabel med klassen min, og jeg har mange ganger vært nær å besvime når jeg har blitt tvunget til å snakke. Jeg forklarer henne situasjonen og hun sier at hun skal ta meg ut på gangen å snakke med meg for å kunne gi meg en muntlig karakter.Noe av det siste hun sa til meg, og noe av det som klistret seg mest fast til meg, var at jeg var en 6er i norsk. Jeg hadde endelig klart noe jeg også. En av mine første 6ere. Hun sier ingenting om at jeg må bli bedre til å snakke høyt i klasserommet, fordi de faglige diskusjonene skulle jeg jo ta på gangen.Timene gikk og karakterene ble satt. 5. Der fikk jeg den i fleisen. Der hadde hun stått og sagt at jeg var en 6er, siden hun skulle respektere at jeg ikke klarte å snakke høyt i klassen. Men så var grunnen til at jeg ikke var oppnåelig nok for en 6er, at jeg ikke var muntlig i timene.Det er sikkert teit og gråte over en 5er. Men når du allerede har fått hørt av læreren din at du skal få 6er, men så trekker hun den tilbake på grunn av en psykisk lidelse, er det faen ikke greit. Og det gjør det ikke noe bedre når de som ikke engang vet hva dobbeltkonsonant er, får utlevert en 5er de også.Så der gikk talentet mitt bort. Skriving regnes ikke lenger som noe jeg er god på. I hvert fall ikke når hvem som helst klarer å få samme karakter som meg, bare fordi de har dumme spørsmål når det gjelder verb.Så takk til norsklæreren som gjorde meg enda mer usikker på meg selv, og fikk angsten til å føle seg veldig betydningsfull i livet mitt igjen. Vet virkelig ikke hvordan jeg skal klare å møte opp til neste norsktime.'),
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
