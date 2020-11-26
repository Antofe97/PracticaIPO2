import 'dart:convert';

import 'package:lab_ipo2/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(CrearGrupo());

class CrearGrupo extends StatelessWidget {
  const CrearGrupo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListFieldsForm(),
    );
  }
}

class ListFieldFormBloc extends FormBloc<String, String> {
  final clubName = TextFieldBloc(name: 'clubName');

  final members = ListFieldBloc<MemberFieldBloc>(name: 'members');

  ListFieldFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        clubName,
        members,
      ],
    );
  }

  void addMember() {
    members.addFieldBloc(MemberFieldBloc(
      name: 'member',
      firstName: TextFieldBloc(name: 'firstName'),
      lastName: TextFieldBloc(name: 'lastName'),
      hobbies: ListFieldBloc(name: 'hobbies'),
    ));
  }

  void removeMember(int index) {
    members.removeFieldBlocAt(index);
  }

  void addHobbyToMember(int memberIndex) {
    members.value[memberIndex].hobbies.addFieldBloc(TextFieldBloc());
  }

  void removeHobbyFromMember(
      {@required int memberIndex, @required int hobbyIndex}) {
    members.value[memberIndex].hobbies.removeFieldBlocAt(hobbyIndex);
  }

  @override
  void onSubmitting() async {
    // Without serialization
    final clubV1 = Club(
      clubName: clubName.value,
      members: members.value.map<Member>((memberField) {
        return Member(
          firstName: memberField.firstName.value,
          lastName: memberField.lastName.value,
          hobbies: memberField.hobbies.value
              .map((hobbyField) => hobbyField.value)
              .toList(),
        );
      }).toList(),
    );

    print('clubV1');
    print(clubV1);

    // With Serialization
    final clubV2 = Club.fromJson(state.toJson());

    ('clubV2');
    print(clubV2);

    emitSuccess(
      canSubmitAgain: true,
      successResponse: JsonEncoder.withIndent('    ').convert(
        state.toJson(),
      ),
    );
  }
}

class MemberFieldBloc extends GroupFieldBloc {
  final TextFieldBloc firstName;
  final TextFieldBloc lastName;
  final ListFieldBloc<TextFieldBloc> hobbies;

  MemberFieldBloc({
    @required this.firstName,
    @required this.lastName,
    @required this.hobbies,
    String name,
  }) : super([firstName, lastName, hobbies], name: name);
}

class Club {
  String clubName;
  List<Member> members;

  Club({this.clubName, this.members});

  Club.fromJson(Map<String, dynamic> json) {
    clubName = json['clubName'];
    if (json['members'] != null) {
      members = List<Member>();
      json['members'].forEach((v) {
        members.add(Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['clubName'] = this.clubName;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '''Club {
  clubName: $clubName,
  members: $members
}''';
}

class Member {
  String firstName;
  String lastName;
  List<String> hobbies;

  Member({this.firstName, this.lastName, this.hobbies});

  Member.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    hobbies = json['hobbies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['hobbies'] = this.hobbies;
    return data;
  }

  @override
  String toString() => '''Member {
  firstName: $firstName,
  lastName: $lastName,
  hobbies: $hobbies
}''';
}

class ListFieldsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListFieldFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = context.bloc<ListFieldFormBloc>();

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
                title: Text('Crear Grupo')),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  formBloc.submit();
                },
                icon: Icon(Icons.group_add),
                label: Text("Añadir"),
              ),
              body: FormBlocListener<ListFieldFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                        Fluttertoast.showToast(
                            msg: "Grupo creado correctamente",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => GestorTabs()));
                  
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 8.0),
                        child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Información del Grupo", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),
                      ),
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.clubName,
                        decoration: InputDecoration(
                          labelText: 'Nombre del Grupo',
                          prefixIcon: Icon(Icons.sentiment_satisfied),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 8.0),
                        child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Miembros", textAlign: TextAlign.left,style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold ,color: Colors.black87),),
                        ),
                      ),
                      BlocBuilder<ListFieldBloc<MemberFieldBloc>,
                          ListFieldBlocState<MemberFieldBloc>>(
                        bloc: formBloc.members,
                        builder: (context, state) {
                          if (state.fieldBlocs.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.fieldBlocs.length,
                              itemBuilder: (context, i) {
                                return MemberCard(
                                  memberIndex: i,
                                  memberField: state.fieldBlocs[i],
                                  onRemoveMember: () =>
                                      formBloc.removeMember(i),
                                  onAddHobby: () =>
                                      formBloc.addHobbyToMember(i),
                                );
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue[100],
                        onPressed: formBloc.addMember,
                        child: Text('Añadir Miembro'),
                      ),
                    ],
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

class MemberCard extends StatelessWidget {
  final int memberIndex;
  final MemberFieldBloc memberField;

  final VoidCallback onRemoveMember;
  final VoidCallback onAddHobby;

  const MemberCard({
    Key key,
    @required this.memberIndex,
    @required this.memberField,
    @required this.onRemoveMember,
    @required this.onAddHobby,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Miembro #${memberIndex + 1}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: onRemoveMember,
                ),
              ],
            ),
            TextFieldBlocBuilder(
              textFieldBloc: memberField.firstName,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: memberField.lastName,
              decoration: InputDecoration(
                labelText: 'Apellidos',
              ),
            ),
            BlocBuilder<ListFieldBloc<TextFieldBloc>,
                ListFieldBlocState<TextFieldBloc>>(
              bloc: memberField.hobbies,
              builder: (context, state) {
                if (state.fieldBlocs.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.fieldBlocs.length,
                    itemBuilder: (context, i) {
                      final hobbyFieldBloc = state.fieldBlocs[i];
                      return Card(
                        color: Colors.blue[50],
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFieldBlocBuilder(
                                textFieldBloc: hobbyFieldBloc,
                                decoration: InputDecoration(
                                  labelText: 'Consideración #${i + 1}',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  memberField.hobbies.removeFieldBlocAt(i),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
            FlatButton(
              color: Colors.white,
              onPressed: onAddHobby,
              child: Text('Añadir Consideración'),
            ),
          ],
        ),
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
