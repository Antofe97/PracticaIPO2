import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab_ipo2/screens/homeScreen.dart';


class InfoPromocion extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Product page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      home: MyHomePage(title: 'Flutter Product page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //The whole application area
      body:SafeArea(
          child: Column(
            children: <Widget>[
            hero(),
            spaceVertical(20),
            //Center Items
            Expanded (
              child: sections(),
            ),

              //Bottom Button
              botones()
          ],
          ),
      ),
    );
  }


  ///************** Hero   ***************************************************/
  Widget hero(){
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 70.0),
          child: Image.asset("images/Promocion1.jpg", width: 500, height: 300,)),
          Positioned(child: appBar(),top: 0,),
        ],
      ),
    );
  }


  Widget appBar(){
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
          Image.asset("images/back_button.png"),
          Container(
            child: Column(
             children: <Widget>[
               Text("2x1", style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Color(0xFF2F2F3E)
               ),),
             ],
            ),
          ),
          Text("        "),
        ],
      ),
    );
  }

  /***** End */






  ///************ SECTIONS  *************************************************/
  Widget sections(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          description(),
          spaceVertical(50),
        
        ],
      ),
    );
  }

  Widget description(){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(height: 110, alignment: Alignment.topLeft, child: Text("Descripción:  ",textAlign: TextAlign.start,style: TextStyle(height: 1.5, fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F2F3E)),)),
              Container(width: 230, child:Text("Disfruta de dos viajes por el precio de uno en circuitos seleccionados. (Se paga el circuito de mayor importe)", textAlign: TextAlign.justify, style: TextStyle(height: 1.5, fontSize: 18, color: Color(0xFF6F8398))))
              ]),

          Padding(padding: EdgeInsets.all(7.0)),

          Row(
                children: <Widget>[
                  Text("Circuitos:  ",textAlign: TextAlign.left,style: TextStyle(height: 1.5, fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),),
                  Text("Ciudad Real, Toledo, Valencia", style: TextStyle(height: 1.5, fontSize: 18, color: Color(0xFF6F8398)))
                  ]),
                  
        ]));
  }



  /***** End */



  ///************** BOTTOM BUTTON ********************************************/
  Widget botones(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(children: <Widget>[
          FlatButton(child: Text("Eliminar",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F2F3E)
            ),
          ), color: Colors.red,
            onPressed: (){
              showAlertDialog(context);
            },),
            Padding(padding: EdgeInsets.all(8.0)),
          FlatButton(child: Text("Modificar",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F2F3E)
            ),
          ), color: Colors.yellow,
            onPressed: (){},)])),
          Text(r"",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w100,
                color: Color(0xFF2F2F3E)
            ),
          )
        ],
      ),
    );
  }

  /***** End */





  ///************** UTILITY WIDGET ********************************************/
  Widget spaceVertical(double size){
    return SizedBox(height: size,);
  }

  Widget spaceHorizontal(double size){
    return SizedBox(width: size,);
  }
 /***** End */
}


showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Eliminar", style: TextStyle(
                 color: Colors.red)),
    onPressed:  () {
      Fluttertoast.showToast(
                            msg: "Se ha eliminado la promoción",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
      Navigator.of(context, rootNavigator: true).pop('dialog');
      
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: (context) => GestorTabs()),);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Eliminar Promoción"),
    content: Text("¿Seguro que desea eliminar esta promoción?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}