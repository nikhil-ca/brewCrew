import 'package:brew_crew/screens/home/brewList.dart';
import 'package:brew_crew/screens/home/settingForm.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: SettingsForm(),
            );
          }
      );
    }

    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseService('').brews,
      child: Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          backgroundColor: Colors.brown[700],
          title: Text('Brew Crew'),
          actions: [
            ElevatedButton.icon(
              onPressed:(){
                _auth.signOut();
              },
                icon: Icon(Icons.person),
                label: Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.brown[700],
              )
            ),
            IconButton(
                onPressed: (){
                  _showSettingsPanel();
                },
                icon: Icon(Icons.settings),
              color: Colors.white,
            )
          ],

        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            )
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
