import 'package:brew_crew/models/userModel.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/firbase_user.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //flags:
  bool _nameFlag = false;
  bool _sugarFlag = false;
  bool _strengthFlag = false;


  //Current Values:
  String _currentName = 'new crew member';
  String _currentSugar = '0';
  int _currentStrength = 100;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    return StreamBuilder(

      stream: DatabaseService(user!.userId).userData,
      builder:(context,snapshot){
        if(snapshot.hasData){
          UserModel userData = snapshot.data as UserModel;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Settings'),
                SizedBox(height: 10,),
                //Updating Name
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) => val!.isEmpty ? 'Enter name' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                    _nameFlag = true;
                  }),
                ),
                SizedBox(height: 10,),
                //Updating Sugar
                DropdownButtonFormField(

                  decoration: textInputDecoration,
                  value: userData.sugar,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugar(s)')
                    );
                  }).toList(),
                  onChanged: (val) => setState(() {
                    _currentSugar = val.toString();
                    _sugarFlag = true;
                  })
                ),
                SizedBox(height: 10,),
                //Updating Strength
                Slider(
                  value: _currentStrength != 100 ? _currentStrength.toDouble() : userData.strength.toDouble(),
                  max: 900,
                  min: 100,
                  divisions: 8,
                  activeColor: Colors.brown[_currentStrength != 100 ? _currentStrength : userData.strength],
                  inactiveColor: Colors.brown[_currentStrength != 100 ? _currentStrength : userData.strength],
                  onChanged: (val) => setState(() {
                    _currentStrength = val.round();
                    _strengthFlag = true;
                  }),
                ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  await DatabaseService(user.userId).updateUserData(
                    _nameFlag ? _currentName : userData.name,
                    _sugarFlag ? _currentSugar : userData.sugar,
                    _strengthFlag ? _currentStrength : userData.strength,
                  );
                  Navigator.pop(context);
                }
              },

              style: ElevatedButton.styleFrom(
              primary: Colors.brown[700]
              ),
              child: Text('Update'),
            )
          ],
            ),
          );
      }else{
          return Loading();
        }
    },

    );
  }
}
