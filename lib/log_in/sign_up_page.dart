import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xpenso/data/model/model.dart';
import 'package:xpenso/log_in/sign_in_page.dart';
import 'package:xpenso/log_in/sign_up/sign_up_bloc.dart';
import 'package:xpenso/log_in/sign_up/sign_up_event.dart';
import 'package:xpenso/log_in/sign_up/sign_up_state.dart';
import 'package:xpenso/screen/home_page.dart';
import 'package:xpenso/screen/intro_page.dart';

class signUpPage extends StatefulWidget{
  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff6674D3),Color(0xffE78BBC)])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Create\nAccount",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 31,color: Colors.white),)),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.only(left: 21),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration:textFieldContDesign(),
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a name!!";
                    }else{
                      return null;
                    }
                  },
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: textFieldDesign(Hint: "Full name")
                ),
              ),
              Container(
                //height: 50,
                width: double.infinity,
                padding: EdgeInsets.only(left: 21),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration:textFieldContDesign(),
                child: TextFormField(
                  controller: emailController,
                    validator: (value){
                      var exp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                      if(value!.isEmpty){
                        return "Email field cannot be empty!";
                      } else if(!exp.hasMatch(value)){
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  cursorColor: Colors.black,
                  decoration: textFieldDesign(Hint: "Email")
                ),
              ),
              Container(
                //height: 50,
                width: double.infinity,
                padding: EdgeInsets.only(left: 21),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration:textFieldContDesign(),
                child: TextFormField(
                  validator: (value){

                    //var exp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                    if(value!.isEmpty){
                      return "Password field cannot be empty!";
                    } /*else if(!exp.hasMatch(value)){
                      return "Please include Minimum 1 Upper case\nMinimum 1 lowercase\nMinimum 1 Numeric Number\nMinimum 1 Special Character";
                    } */else {
                      return null;
                    }
                  },
                  obscureText: !isPasswordVisible ,
                  controller: passController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                          onTap: (){
                            isPasswordVisible = !isPasswordVisible;
                            setState(() {

                            });
                          },
                          child: isPasswordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)),
                      hintText: " Password",
                      hintStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: Color(0xff4C4C4C))),
                ),
              ),
          BlocListener<registerBloc, registerState>(
            listener: (context, state) {
              if (state is registerLoadingState) {
                isLoading = true;
                setState(() {

                });
              }

              if (state is registerFailureState) {
                isLoading = false;
                setState(() {

                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMsg)));
              }

              if (state is registerSuccessState) {
                isLoading = false;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>signInPage()));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Registered successfully!!")));
              }
            },
             child:  ElevatedButton(onPressed: ()async{
               if(formKey.currentState!.validate()){
                 context.read<registerBloc>().add(registerUserEvent(newUser: userModel(name: nameController.text, email: emailController.text, monNo: "254", password: passController.text, createdAt: DateTime.now().millisecondsSinceEpoch.toString())));
               }
               },
                style:ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: Size(140, 40),
                    backgroundColor: Color(0xff6674D3),
                    foregroundColor: Colors.white
                ),
                child:isLoading ? const Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 11,),
                    Text('Registering...')
                  ],
                ) : Text("Sign Up",style: TextStyle(fontFamily:"Poppins",fontSize: 21,color: Colors.white),),),
          ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aready have an account?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "Poppins",
                    ),),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signInPage()));
                  }, child:  Text('Log in',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 15),),)
                ],
              ),
              SizedBox(height: 10,),

            ],
          ),
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

  InputDecoration textFieldDesign({required String Hint}) {
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