import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab_ipo2/screens/homeScreen.dart';



class InfoCircuito extends StatelessWidget {
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
          child: Image.asset("images/CiudadReal.jpg",)),
         
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
               
               Text("Ciudad Real", style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Color(0xFF2F2F3E)
               ),),
             ],
            ),
          ),
          Text("        ")
          
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
          property(),
        ],
      ),
    );
  }

  Widget description(){
    return Text(
      "Visita algunos de los rincones más bonitos de Ciudad Real, Daimiel y Villanueva de los Infantes en este circuito pensado para toda la familia. Excursiones incluidas: Ciudad Real (4 horas), Parque Nacional Tablas de Daimiel (3 horas), Yacimiento Arqueológico de Jamila (2 horas).",
      textAlign: TextAlign.justify,
      style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),);
  }

  Widget property(){
    return Container(
      padding: EdgeInsets.only(right: 20,left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("LOCALIDADES", textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F2F3E)
              ),
              ),
              spaceVertical(10),
              colorSelector(),
            ],
          ),
          size()
        ],
      ),
    );
  }

  Widget colorSelector(){
    return Container(
      child: Column(
        children: <Widget>[
          Text("Ciudad Real", textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14,
              //fontWeight: FontWeight.bold,
              color: Color(0xFF2F2F3E)
          ),
        ),
        Text("Daimiel", textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14,
              //fontWeight: FontWeight.bold,
              color: Color(0xFF2F2F3E)
          ),
        ),
        Text("Villanueva de los Infantes", textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 14,
              //fontWeight: FontWeight.bold,
              color: Color(0xFF2F2F3E)
          ),
        ),
        
        ]
      )
      
    );
  }

  Widget size(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("DURACIÓN", textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F2F3E)
          ),
        ),
        spaceVertical(10),
        Container(
          width: 85,
          padding: EdgeInsets.all(10),
          color: Color(0xFFF5F8FB),
          child: Text("9 horas",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F2F3E)
            ),
          ),
        )

      ],
    );
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
          Text(r"20€",
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


class ColorTicker extends StatelessWidget{
  final Color color;
  final bool selected;
  final VoidCallback selectedCallback;
  ColorTicker({this.color,this.selected,this.selectedCallback});


  @override
  Widget build(BuildContext context) {
    print(selected);
    return
      GestureDetector(
        onTap: (){
          selectedCallback();
        },
        child: Container(
            padding: EdgeInsets.all(7),
            margin: EdgeInsets.all(5),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.7)),
                 child: selected ? Image.asset("images/checker.png") :
               Container(),
        )
      );
  }

  

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
                            msg: "Se ha eliminado el circuito",
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
    title: Text("Eliminar Circuito"),
    content: Text("¿Seguro que desea eliminar este circuito?"),
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