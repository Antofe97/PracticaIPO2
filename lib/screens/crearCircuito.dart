import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:lab_ipo2/screens/homeScreen.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(CrearCircuito());

class CrearCircuito extends StatelessWidget {
  const CrearCircuito({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WizardForm(),
    );
  }
}

class WizardFormBloc extends FormBloc<String, String> {
  final username = TextFieldBloc(
    validators: [
      
    ],
  );

  final email = TextFieldBloc(
    validators: [
      
    ],
  );

  final password = TextFieldBloc(
    validators: [
      
    ],
  );

  final selectCiudadReal = MultiSelectFieldBloc<String,dynamic>(
    items: ['Ciudad Real', 'Daimiel', 'Puertollano', 'Alcázar de San Juan', 'Moral de Calatrava']
  );

  final selectToledo = MultiSelectFieldBloc<String,dynamic>(
    items: ['Toledo', 'Illescas', 'Bargas', 'Talavera de la Reina']
  );

  final selectValencia = MultiSelectFieldBloc<String,dynamic>(
    items: ['Valencia', 'Gandía', 'Benidorm', 'Alicante', 'Villajoyosa', 'Peñiscola']
  );

  final firstName = TextFieldBloc();

  final lastName = TextFieldBloc();

  final gender = SelectFieldBloc(
    items: ['Male', 'Female'],
  );

  final birthDate = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );

  final github = TextFieldBloc();

  final twitter = TextFieldBloc();

  final facebook = TextFieldBloc();

  WizardFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [username, email, password],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [selectCiudadReal,selectToledo,selectValencia],
    );
    addFieldBlocs(
      step: 2,
      fieldBlocs: [github, twitter, facebook],
    );
  }

  bool _showEmailTakenError = false;

  @override
  void onSubmitting() async {
    if (state.currentStep == 0) {
      await Future.delayed(Duration(milliseconds: 500));

      if (_showEmailTakenError) {
        _showEmailTakenError = false;

        email.addError('That email is already taken');

        emitFailure();
      } else {
        emitSuccess();
      }
    } else if (state.currentStep == 1) {
      emitSuccess();
    } else if (state.currentStep == 2) {
      await Future.delayed(Duration(milliseconds: 500));

      emitSuccess();
    }
  }
}

class WizardForm extends StatefulWidget {
  @override
  _WizardFormState createState() => _WizardFormState();
}

class _WizardFormState extends State<WizardForm> {
  var _type = StepperType.horizontal;

  void _toggleType() {
    setState(() {
      if (_type == StepperType.horizontal) {
        _type = StepperType.vertical;
      } else {
        _type = StepperType.horizontal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WizardFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<WizardFormBloc>(context);
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(leading: BackButton(onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => GestorTabs()),);
              },
              color: Colors.white),
                title: Text('Crear Circuito'),
                
              ),
              body: SafeArea(
                child: FormBlocListener<WizardFormBloc, String, String>(
                  onSubmitting: (context, state) => LoadingDialog.show(context),
                  onSuccess: (context, state) {
                    LoadingDialog.hide(context);

                    if (state.stepCompleted == state.lastStep) {
                      
                          Fluttertoast.showToast(
                            msg: "Circuito creado correctamente",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => GestorTabs()));
                          
                          
                    }
                  },
                  onFailure: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  child: StepperFormBlocBuilder<WizardFormBloc>(
                    type: _type,
                    physics: ClampingScrollPhysics(),
                    stepsBuilder: (formBloc) {
                      return [
                        _accountStep(formBloc),
                        _personalStep(formBloc),
                        _socialStep(formBloc),
                      ];
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FormBlocStep _accountStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: Text('Información'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.username,
            keyboardType: TextInputType.emailAddress,
            enableOnlyWhenFormBlocCanSubmit: true,
            decoration: InputDecoration(
              labelText: 'Nombre Circuito',
              prefixIcon: Icon(Icons.navigation),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.email,
            maxLines: 3,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Descripción',
              prefixIcon: Icon(Icons.description),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.password,
            keyboardType: TextInputType.number,
            
            decoration: InputDecoration(
              labelText: 'Precio',
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _personalStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: Text('Localidades'),
      content: Column(
        children: <Widget>[
          Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                alignment: Alignment.topLeft,
                child: Text("Ciudad Real", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
              ),),
          CheckboxGroupFieldBlocBuilder<String>(
            multiSelectFieldBloc: wizardFormBloc.selectCiudadReal,
            itemBuilder: (context, item) => item,
            decoration: InputDecoration(
              
              prefixIcon: SizedBox()
            ),
          ),
          Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                alignment: Alignment.topLeft,
                child: Text("Toledo", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
              ),),
          CheckboxGroupFieldBlocBuilder<String>(
            multiSelectFieldBloc: wizardFormBloc.selectToledo,
            itemBuilder: (context, item) => item,
            decoration: InputDecoration(
              
              prefixIcon: SizedBox()
            ),
          ),
          Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Align(
                alignment: Alignment.topLeft,
                child: Text("Valencia", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
              ),),
          CheckboxGroupFieldBlocBuilder<String>(
            multiSelectFieldBloc: wizardFormBloc.selectValencia,
            itemBuilder: (context, item) => item,
            decoration: InputDecoration(
              
              prefixIcon: SizedBox()
            ),
          )
        ],
      ),
    );
  }

  

  FormBlocStep _socialStep(WizardFormBloc wizardFormBloc) {

final controller = MapController(
    location: LatLng(38.98, -3.92),
  );

  void _incrementCounter() {
    controller.location = LatLng(38.88, -3.92);
  }


  final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  controller.tileSize = 256 / devicePixelRatio;



    return FormBlocStep(
      title: Text('Mapa'),
      content: Column(
        children: <Widget>[
          Container(height: 470,
          child: Map(
            controller: controller,
            provider: const CachedGoogleMapProvider(),
          ))
          
        ],
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => WizardForm())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}

class CachedGoogleMapProvider extends MapProvider {
  const CachedGoogleMapProvider();

  @override
  ImageProvider getTile(int x, int y, int z) {
    //Can also use CachedNetworkImageProvider.
    return NetworkImage(
        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425');
  }
}


