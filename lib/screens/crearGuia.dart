import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:lab_ipo2/screens/homeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(CrearGuia());

class CrearGuia extends StatelessWidget {
  const CrearGuia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllFieldsForm(),
    );
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
  
  final textNombre = TextFieldBloc();

  final textApellidos = TextFieldBloc();

  final textTelefono = TextFieldBloc();

  final textEmail = TextFieldBloc();

  final idiomas = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Español',
      'Inglés',
      'Francés',
      'Italiano',
      'Alemán',
      'Chino'
    ]
  );
  

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
    
      textNombre,
      textApellidos,
      textTelefono,
      textEmail,
      idiomas
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
                icon: Icon(Icons.person_add),
                label: Text("Añadir"),
              ),
              appBar: AppBar(leading: BackButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => GestorTabs()),);
              },
              color: Colors.white),
              title: Text('Añadir Guia')),
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
                          child: Text("Datos Personales", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.textNombre,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            prefixIcon: Icon(Icons.person)
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.textApellidos,
                          decoration: InputDecoration(
                            labelText: 'Apellidos',
                            prefixIcon: Icon(Icons.person)
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.textTelefono,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Teléfono',
                            prefixIcon: Icon(Icons.phone)
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.textEmail,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email)
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 8.0),
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Idiomas", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.idiomas,
                          itemBuilder: (context, item) => item,
                          decoration: InputDecoration(
                            
                            prefixIcon: SizedBox()
                          ),
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
    child: Text("Añadir"),
    onPressed:  () {
      Fluttertoast.showToast(
                            msg: "Se ha añadido el guia",
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
    title: Text("Añadir Guia"),
    content: Text("¿Desea añadir este guia?"),
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