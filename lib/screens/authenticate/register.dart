import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();

  //Text states:
  String email = '';
  String password = '';

  //Formkey
  final _formKey = GlobalKey<FormState>();

  //error
  String error = '';

  //loading
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
              key:_formKey,
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'e-mail'),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        validator: (val) => val!.isEmpty ? 'enter an email' : null,
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'password'),
                        validator: (val) => val!.length < 6 ? 'password should at least be of length 6' : null,
                        obscureText: true,
                        onChanged: (val){
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          onPressed: () async{
                            if(_formKey.currentState!.validate()){
                              setState(() => loading = true);
                              dynamic user = await _auth.registerWithEmailAndPassword(email, password);
                              print(email);
                              print(password);
                              print(user);
                              if(user == null){
                                setState(()  {
                                  error = 'Enter valid email ID';
                                  loading = false;
                                }
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.brown[700],
                          ),
                          child: Text('Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                      ),
                      SizedBox(height: 10,),
                      TextButton(
                          onPressed: (){
                            widget.toggleView();
                          },
                          child: Text('Already registered? Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),)
                      ),
                      Text(error,
                      style: TextStyle(
                        color: Colors.red,
                      ),)
                    ]
                )
            )
        ),
      ),
    );
  }
}


