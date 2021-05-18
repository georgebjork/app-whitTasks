import 'package:app_whittasks/Classes/TaskProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'Classes/ThemeProvider.dart';
import 'Classes/httpService.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget{

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{

  //Basic style for font size 
  TextStyle style = TextStyle(fontSize: 20.0);
  
  //Email and password controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Service object to do api calls 
  final service = httpService();
  
  void initState()
  {
    context.read<ThemeProvider>().applyTheme();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          //Border color and width 
          borderSide: BorderSide(color: Colors.grey[800], width: 5.0,),
          //Adds the rounded edges 
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          //Border color red for incorrect input 
          borderSide: BorderSide(color: Colors.red[900], width: 5.0,),
          borderRadius: BorderRadius.circular(20.0),
        ),
        //Mail icon
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final passwordField = TextField(
      //Hides the text for the input 
      obscureText: true,
      style: style,
      controller: passwordController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          //Focued border is grey 
          borderSide: BorderSide(color: Colors.grey[800], width: 5.0,),
          //Gives rounded edges 
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          //Red border for error 
          borderSide: BorderSide(color: Colors.red[900], width: 5.0,),
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(Icons.password),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );

    final loginButon = Material(
      //Gives button rounded edges
      borderRadius: BorderRadius.circular(20.0),
      //Red with a little opacity 
      color: Colors.red[900].withOpacity(0.6),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          //Gives api email and password
          Response res = await service.login(emailController.text, passwordController.text);
          if(res.statusCode == 200){
            //If true add the user to the provider 
            Provider.of<TaskProvider>(context, listen: false).addUser(res.body);
            //Go to the home page
            Navigator.pushNamed(context, '/home');
          }
        },
        child: Text("Login",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white54.withOpacity(0.9),
            fontWeight: FontWeight.bold)),
        ),
      );

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            emailField,
            SizedBox(height: 20),
            passwordField,
            SizedBox(height: 20),
            loginButon,
          ],
        ),
      ),
    );
  }
}