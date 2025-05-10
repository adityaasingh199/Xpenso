import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xpenso/log_in/sign_in_page.dart';
import 'package:xpenso/screen/home_page.dart';

class introPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("asset/image/monety.png",height: 28,),
                      Text(" Monety",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 350,
                    margin: EdgeInsets.only(bottom: 50),
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0x329e9e9e)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Easy way to monitor your expense",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
                        SizedBox(height: 15,),
                        Text("Safe your future by managing your expense right now",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.grey),),
                        SizedBox(height: 45,),
                        Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              margin: EdgeInsets.only(right: 3),
                              decoration: BoxDecoration(
                                  color: Color(0xE29E9E9E),
                                  shape: BoxShape.circle
                              ),
                            ),
                            Container(
                              height: 8,
                              width: 8,
                              margin: EdgeInsets.only(right: 3),
                              decoration: BoxDecoration(
                                  color: Color(0xE29E9E9E),
                                  shape: BoxShape.circle
                              ),
                            ),
                            Container(
                              height: 8,
                              width: 8,
                              margin: EdgeInsets.only(right: 3),
                              decoration: BoxDecoration(
                                  color: Color(0xffEDC88F),
                                  shape: BoxShape.circle
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                ],
              ),
              Positioned(
                  bottom: 200,
                  child: SizedBox(
                      height: 480,
                      width: 320,
                      child: Image.asset("asset/image/monety_bg.png",fit: BoxFit.cover,))),
              Positioned(
                right: 0,
                bottom: 12,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signInPage()));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE78BBC)
                      ),
                      child: Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 25,),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}