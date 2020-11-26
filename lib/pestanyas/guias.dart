import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Guias extends StatelessWidget {
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = new List<Widget>();
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/dataGuias.json");
      List<dynamic> dataJSON = jsonDecode(dataString);


      dataJSON.forEach((object) {

        String finalString= "";
        List<dynamic> dataList = object["idiomas"];
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
                child: Image.asset(object["imagenGuia"],width: 100,height: 100,fit: BoxFit.cover,),
              ),
              Flexible(
                //width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(object["nombreGuia"], style: TextStyle(fontSize: 18.0),),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                        child: Row(
                          children: <Widget>[
                            Text("Idiomas: ",style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black54),),
                            Text(finalString, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0,color: Colors.black54,),maxLines: 1,),
                          ]
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                        child: Row(
                          children: <Widget>[
                            Text("Teléfono: ",style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black54),),
                            Text("${object["telefono"]}",style: TextStyle(fontSize: 12.0,color: Colors.black54),)
                          ]
                        )
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                        child: Row(
                          children: <Widget>[
                            Text("Email: ",style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black54),),
                            Text("${object["email"]}",style: TextStyle(fontSize: 12.0,color: Colors.black54),)
                          ]
                        )
                      ),
                      
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
          child: Column( children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                alignment: Alignment.topLeft,
                child: Text("Guias Turísticos", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
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