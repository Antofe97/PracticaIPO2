import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab_ipo2/screens/homeScreen.dart';


class InfoGrupo extends StatelessWidget {
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
          child: Image.asset("images/Grupo1.jpg", width: 500, height: 300,)), 
          
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
               
               Text("CorreCaminos", style: TextStyle(
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
          property(),
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
              Text("Nombre Grupo:  ",textAlign: TextAlign.left,style: TextStyle(height: 1.5, fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F2F3E)),),
              Text("CorreCaminos", style: TextStyle(height: 1.5, fontSize: 18, color: Color(0xFF6F8398)))
              ]),

          Padding(padding: EdgeInsets.all(7.0)),

          Row(
                children: <Widget>[
                  Text("Nº Integrantes:  ",textAlign: TextAlign.left,style: TextStyle(height: 1.5, fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),),
                  Text("4", style: TextStyle(height: 1.5, fontSize: 18, color: Color(0xFF6F8398)))
                  ]),
          
          Padding(padding: EdgeInsets.all(7.0)),

          Row(
                children: <Widget>[
                  Text("Integrantes:  ",textAlign: TextAlign.left,style: TextStyle(height: 1.5, fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),),
                  Text("Antonio, Fernando, María, Lucía", style: TextStyle(height: 1.5, fontSize: 18, color: Color(0xFF6F8398)))
                  ]),
          
          Padding(padding: EdgeInsets.all(7.0)),

          Row(
                children: <Widget>[
                  Text("Intereses:  ",textAlign: TextAlign.left,style: TextStyle(height: 1.5, fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)),),
                  Text("Excursiones, visitas a museos", style: TextStyle(height: 1.5, fontSize: 18, color: Color(0xFF6F8398)))
                  ]),
                                
        ]));
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
              
              spaceVertical(10),
             
            ],
          ),
         
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
        Text("Toledo", textAlign: TextAlign.left,
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
        Text("Puntuación:", textAlign: TextAlign.left,
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
          child: Text(" 4.5/5",
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
                            msg: "Se ha eliminado el grupo",
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
    title: Text("Eliminar Grupo"),
    content: Text("¿Seguro que desea eliminar este grupo?"),
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