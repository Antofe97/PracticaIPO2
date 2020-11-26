import 'package:flutter/material.dart';
import 'package:lab_ipo2/main.dart';
import 'package:lab_ipo2/pestanyas/circuitos.dart';
import 'package:lab_ipo2/pestanyas/grupos.dart';
import 'package:lab_ipo2/pestanyas/guias.dart';
import 'package:lab_ipo2/pestanyas/historial.dart';
import 'package:lab_ipo2/screens/crearGuia.dart';
import 'package:lab_ipo2/screens/crearHistorial.dart';
import 'package:lab_ipo2/screens/crearPromociones.dart';


import 'package:lab_ipo2/pestanyas/promociones.dart';
import 'package:lab_ipo2/screens/crearGrupo.dart';
import 'package:lab_ipo2/screens/crearCircuito.dart';
import 'package:lab_ipo2/screens/infoCircuito.dart';
import 'package:lab_ipo2/screens/infoGuia.dart';
import 'package:lab_ipo2/screens/infoGrupo.dart';
import 'package:lab_ipo2/screens/infoPromocion.dart';



import 'package:multilevel_drawer/multilevel_drawer.dart';


class GestorTabs extends StatefulWidget {
  @override
  _GestorTabsState createState() => _GestorTabsState();
}

class _GestorTabsState extends State<GestorTabs>
    with SingleTickerProviderStateMixin {
  TabController controlador;

  
  final List<MyTabs> _tabs = [new MyTabs(title: "Circuitos", color: Colors.teal[200], icon: Icon(Icons.navigation)), 
                              new MyTabs(title: "Historial",color: Colors.orange[200], icon: Icon(Icons.history)), 
                              new MyTabs(title: "Guias",color: Colors.red[200], icon: Icon(Icons.person)), 
                              new MyTabs(title: "Grupos Turistas",color: Colors.purple[200], icon: Icon(Icons.people)), 
                              new MyTabs(title: "Promociones",color: Colors.green[200], icon: Icon(Icons.monetization_on)),];
  MyTabs _myHandler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controlador = new TabController(
      length: 5,
      vsync: this,
    );
    _myHandler = _tabs[0];
    controlador.addListener(_handleSelected);
  }

 void _handleSelected() {
    setState(() {
       _myHandler= _tabs[controlador.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MultiLevelDrawer(
          backgroundColor: Colors.white,
          rippleColor: Colors.white,
          subMenuBackgroundColor: Colors.grey.shade100,
          header: Container(                  // Header for Drawer
            height: MediaQuery.of(context).size.height * 0.25, 
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/dp_default.png",width: 100,height: 100,),
                SizedBox(height: 10,),
                Text("Antonio Felipe Rojo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            )),
          ),

          children: [           // Child Elements for Each Drawer Item
            MLMenuItem(
                leading: Icon(Icons.person),
                
                content: Text(
                  "Mi Perfil",
                ),
                
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.settings),
                
                content: Text("Ajustes"),
                onClick: () {},
                
                ),
            MLMenuItem(
              leading: Icon(Icons.notifications),
              content: Text("Notificaciones"),
              onClick: () {},
            ),
            MLMenuItem(
                leading: GestureDetector(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => App()),);
                  },child: Icon(Icons.exit_to_app)),
                
                content: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => App()),);
                  },
                  child:Container(
                    child: Text("Cerrar Sesión",)
                  )
                ),
                
                onClick: () { 
                }),
          ],
        ),
      appBar: new AppBar(
        title: new Text(_myHandler.title),
        backgroundColor: _myHandler.color,
      ),
      bottomNavigationBar: Container(
        child: new TabBar(
          tabs: <Widget>[
            new Tab(
              icon: _tabs[0].icon,
            ),
            new Tab(
              icon: _tabs[1].icon,
            ),
            new Tab(
              icon: _tabs[2].icon, 
            ),
            new Tab(
              icon: _tabs[3].icon,
            ),
            new Tab(
              icon: _tabs[4].icon,
            ),
          ],
          controller: controlador,
        ),
        color: _myHandler.color,
      ),
      body: new TabBarView(
        controller: controlador,
        children: <Widget>[
          GestureDetector(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoCircuito()));
            },
            child: new Circuitos()
          ), 
          new Historial(),
          GestureDetector(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoGuia()));
            },
            child: new Guias()
          ),
          GestureDetector(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoGrupo()));
            },
            child: new Grupos()
          ),
          GestureDetector(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoPromocion()));
          }, 
          child: new Promociones()
          )
          ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(controlador.index == 0){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrearCircuito()),
          );
        }

        if(controlador.index == 1){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrearHistorial()),
          );
        }

        if(controlador.index == 2){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrearGuia()),
          );
        }
        
        if(controlador.index == 3){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrearGrupo()),
          );
        }

        if(controlador.index == 4){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrearPromociones()),
          );
        }
      },
          backgroundColor: _myHandler.color,
      child: Icon(Icons.add,color: Colors.white,)),
    );
  }
}

class MyTabs {
  final String title;
  final Color color;
  final Icon icon;
  MyTabs({this.title,this.color,this.icon});
}
