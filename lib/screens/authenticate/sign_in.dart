import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthService _auth = AuthService();

  //Key
  final _formKey = GlobalKey<FormState>();

  //Text states:
  String email = '';
  String password = '';

  //error
  String error = '';

  //loading
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        centerTitle: true,
        title: Text('Brew Crew',
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB( 50,50,50,0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'e-mail'),
                  validator: (val) => val!.isEmpty ? 'enter an email ID' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'password'),
                  validator: (val) => val!.length <6 ? 'Password should be at least of 6 chars' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic user = await _auth.signInWithEmailAndPassword(email, password);
                        if(user == null){
                          setState(() {
                            error = 'Invalid login credentials';
                            loading = false;
                          });
                        }
                      }
                      print(email);
                      print(password);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown[700],
                    ),
                    child: Text('Sign In',
                    style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.bold,
                    ),
                    )
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: (){
                      widget.toggleView();
                    },
                    child: Text('Not registered yet? Click here',
                    style: TextStyle(
                      color: Colors.white
                    ),)
                ),
                Text(error,
                style: TextStyle(
                  color: Colors.red
                ),)
              ]
            )
          )
        ),
      ),
    );
  }
}
