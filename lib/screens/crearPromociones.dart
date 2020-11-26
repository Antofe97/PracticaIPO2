import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab_ipo2/screens/homeScreen.dart';

void main() => runApp(CrearPromociones());

class CrearPromociones extends StatelessWidget {
  const CrearPromociones({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PromocionForm(),
    );
  }
}

class PromocionFormBloc extends FormBloc<String, String> {
  final nombrePromocion = TextFieldBloc();
  final descripcion = TextFieldBloc();
  final descuento = TextFieldBloc();

  final circuitos = MultiSelectFieldBloc<String,dynamic>(
    items: ['Ciudad Real', 'Toledo', 'Galicia', 'Valencia']
  );


  PromocionFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        nombrePromocion,
        descripcion,
        descuento,
        circuitos
      ],
    );
  }

  @override
  void onSubmitting() async {
  }
}

class PromocionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromocionFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<PromocionFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(leading: BackButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => GestorTabs()),);
              },
                color: Colors.white),
                title: Text('Crear Promoción')),
                floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "Promoción creada correctamente",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GestorTabs()));
                },
                icon: Icon(Icons.add),
                label: Text("Crear"),
              ),
              body: FormBlocListener<PromocionFormBloc, String,
                  String>(
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
                          padding: EdgeInsets.only(left: 20.0),
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Información de la Promoción", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.nombrePromocion,
                          keyboardType: TextInputType.emailAddress,
                          enableOnlyWhenFormBlocCanSubmit: true,
                          decoration: InputDecoration(
                            labelText: 'Nombre Promoción',
                            prefixIcon: Icon(Icons.navigation),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.descripcion,
                          maxLines: 3,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Descripción',
                            prefixIcon: Icon(Icons.description),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.descuento,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Descuento',
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Circuitos dentro de la Promoción", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),),
                        CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.circuitos,
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
