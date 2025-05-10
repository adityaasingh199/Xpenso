import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xpenso/log_in/log_in/login_bloc.dart';
import 'package:xpenso/log_in/log_in/login_event.dart';
import 'package:xpenso/log_in/log_in/login_state.dart';
import 'package:xpenso/log_in/sign_up_page.dart';
import 'package:xpenso/screen/home_page.dart';
import 'package:xpenso/screen/intro_page.dart';

class signInPage extends StatefulWidget {
  static const String LOGIN_KEY = 'isLogin';

  @override
  State<signInPage> createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff6674D3), Color(0xffE78BBC)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome\nBack",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 31,
                      color: Colors.white),
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(left: 21),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: textFieldContDesign(),
              child: TextField(
                controller: emailController,
                cursorColor: Colors.black,
                decoration: textFieldDesign( Hint: "Enter Email")
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(left: 21),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: textFieldContDesign(),
              child: Center(
                child: TextField(
                  controller: passController,
                  cursorColor: Colors.black,
                  decoration: textFieldDesign( Hint: "Enter Password")
                ),
              ),
            ),
            BlocListener<loginBloc,loginState>(
              listener: (context,state){
                if(state is loginLoadingState){
                  isLoading = true;
                  setState(() {
                  });
                }
                if(state is logininSuccessState){
                  isLoading = false;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => homePage()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Logged in successfully!!")));
                }
                if(state is loginFailureState){
                  isLoading = false;
                  setState(() {

                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                }

              },
              child: ElevatedButton(
                onPressed: () async {
                  context.read<loginBloc>().add(AuthenticateUserEvent(email:emailController.text,pass: passController.text));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: Size(140, 40),
                    backgroundColor: Color(0xff6674D3),
                    foregroundColor: Colors.white),
                child: isLoading ? Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 11,),
                    Text('Logging in...')
                  ],
                ):Text(
                  "Log in",
                  style: TextStyle(
                      fontFamily: "Poppins", fontSize: 21, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Foget Password ?",
              style: TextStyle(
                  fontFamily: "Poppins", fontSize: 15, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: "Poppins",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => signUpPage()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 15),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration textFieldContDesign(){
    return BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 2)]);
  }

  InputDecoration textFieldDesign({required String Hint}){
    return InputDecoration(
      hintText: " $Hint",
      hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: Color(0xff4C4C4C)),
      border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.never
    );
  }
}
