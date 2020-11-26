import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:lab_ipo2/screens/homeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(CrearHistorial());

class CrearHistorial extends StatelessWidget {
  const CrearHistorial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllFieldsForm(),
    );
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
  
  final selectCircuito = SelectFieldBloc(
    items: ['Ciudad Real', 'Toledo', 'Galicia', 'Valencia'],
  );

  final selectGrupo = SelectFieldBloc(
    items: ['CorreCaminos', 'Club Excursionistas', 'Novatos'],
  );

  final date = InputFieldBloc<DateTime, Object>();

  final selectPromocion = SelectFieldBloc(
    items: ['2x1 en Circuitos Seleccionados', 'Primer Viaje (75% descuento)'],
  );
  

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
    
      selectCircuito,
      selectGrupo,
      date,
      selectPromocion
    ]);
  }

  @override
  void onSubmitting() async {
  }
}

class AllFieldsForm extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showAlertDialog(context);
                },
                icon: Icon(Icons.navigate_next),
                label: Text("CONTRATAR"),
              ),
              appBar: AppBar(leading: BackButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => GestorTabs()),);
              },
              color: Colors.white),
              title: Text('Contratar Circuito')),
              body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 8.0),
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Seleccionar Circuito", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.selectCircuito,
                          decoration: InputDecoration(
                            labelText: 'Circuito',
                            prefixIcon: Icon(Icons.sentiment_satisfied),
                          ),
                          itemBuilder: (context, value) => value,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 8.0),
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Seleccionar Grupo", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.selectGrupo,
                          decoration: InputDecoration(
                            labelText: 'Grupo Turistas',
                            prefixIcon: Icon(Icons.sentiment_satisfied),
                          ),
                          itemBuilder: (context, value) => value,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 8.0),
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Fecha Realización", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.date,
                          format: DateFormat('dd-mm-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Fecha',
                            prefixIcon: Icon(Icons.calendar_today),
                            
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 8.0),
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Promociones Disponibles", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.selectPromocion,
                          decoration: InputDecoration(
                            labelText: 'Promoción',
                            prefixIcon: Icon(Icons.sentiment_satisfied),
                          ),
                          itemBuilder: (context, value) => value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
    child: Text("Contratar"),
    onPressed:  () {
      Fluttertoast.showToast(
                            msg: "Se ha contratado el circuito",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
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
    title: Text("Contratar Circuito"),
    content: Text("¿Realizar contratación?"),
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
