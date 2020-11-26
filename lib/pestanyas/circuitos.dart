import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lab_ipo2/screens/infoCircuito.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//void main() => runApp(Circuitos());

class Circuitos extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

var bannerItems = ["Madrid", "Camino del Norte", "Tour Flamenco por Andalucia", "Pirineos Orientales: Val D´Aran y P. N. de Aigüestortes"];
var bannerImage = [
  "images/Madrid.jpg",
  "images/CaminoDelNorte.jpg",
  "images/Flamenco.jpg",
  "images/Pirineos.jpg"
];
var bannerDesc = ["Visita todos los rincones de Madrid", "Conoce todo el norte de España", "Ahora con un 40% de descuento", "Oferta 2x1", "Gratis para menores de 13 años"];

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = new List<Widget>();
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/dataCircuitos.json");
      List<dynamic> dataJSON = jsonDecode(dataString);


      dataJSON.forEach((object) {

        String finalString= "";
        List<dynamic> dataList = object["localidadesCircuito"];
        dataList.forEach((item){
          finalString = finalString + item + " | ";
        });

        items.add(Padding(padding: EdgeInsets.all(2.0),
        
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2.0,
                blurRadius: 5.0
              ),
            ]
          ),
          margin: EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                child: Image.asset(object["imagenCircuito"],width: 100,height: 100,fit: BoxFit.cover,),
              ),
              SizedBox(
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                        child: Text(object["nombreCircuito"], style: TextStyle(fontSize: 18.0),)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                        child: Text(finalString,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0,color: Colors.black54,),maxLines: 1,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                        child:Row(
                          children: <Widget>[
                          Text("Precio: ", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold ,color: Colors.black54)),
                          Text("${object["precio"]}€",style: TextStyle(fontSize: 12.0,color: Colors.black54),)]
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),));
      });

      return items;
    }

    return Scaffold(
      
      
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                alignment: Alignment.topLeft,
                child: Text("Destacados", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
              ),),
              BannerWidgetArea(),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: 
              Align(
                alignment: Alignment.topLeft,
                child: Text("Todos los circuitos", textAlign: TextAlign.left,style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
              ),),
              Container(
                child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                        
                      }
                    }),
              )
            ],
          ),
        )),
      ),
       
    );
  }
}

class BannerWidgetArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    PageController controller =
        PageController(viewportFraction: 0.8, initialPage: 1);

    List<Widget> banners = new List<Widget>();

    for (int x = 0; x < bannerItems.length; x++) {
      var bannerView = Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                          spreadRadius: 1.0)
                    ]),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Image.asset(
                  bannerImage[x],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bannerItems[x],
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    Text(
                      bannerDesc[x],
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
      banners.add(bannerView);
    }

    return Container(
      width: screenWidth,
      height: screenWidth * 9 / 16,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
