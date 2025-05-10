

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xpenso/data/model/cat_model.dart';
import 'package:xpenso/data/model/expense_model.dart';
import 'package:xpenso/domain/app_constants.dart';
import 'package:xpenso/espense/expense_bloc.dart';
import 'package:xpenso/espense/expense_event.dart';
import 'package:xpenso/espense/expense_state.dart';


import '../../data/model/filter_expense_model.dart';

class homeBottomPage extends StatefulWidget{

  @override
  State<homeBottomPage> createState() => _homeBottomPageState();
}

class _homeBottomPageState extends State<homeBottomPage> {

  List<filterExpenseModel> allFilteredExpenses = [];

  DateFormat df = DateFormat.yMMMEd();

  List<String> mExpenseFilterType = ["Date wise", "Month wise", "Year wise","Category wise"];

  String selectedFilterType = "Date wise";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   context.read<expenseBloc>().add(getInitialExpEvent());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<expenseBloc,expenseState>(
            builder: (context,state) {

              if(state is expenseLoadingState){
                return Center( child: CircularProgressIndicator(),);
              }
              if(state is expenseErrorState){
                return Center(child: Text(state.errorMsg,),);
              }

              if(state is expenseLoadedState) {

                allFilteredExpenses = state.allExpenses;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "asset/image/monety.png", height: 28,),
                                Text(" Monety", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),),
                              ],
                            ),
                            Icon(Icons.search_rounded, size: 25,)
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image(
                                    image: AssetImage("asset/image/avatar.png"),
                                    height: 45,
                                    width: 45,
                                    fit: BoxFit.cover,),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(" Morning", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),),
                                    Text(" Aditya Singh", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),),
                                  ],
                                ),
                              ],
                            ),
                            DropdownMenu(
                              width: 150,
                              inputDecorationTheme: InputDecorationTheme(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none
                                ),
                                filled: true,
                                fillColor: Color(0x45194cff),
                              ),
                              onSelected: (value){
                                if(value == "Date wise"){
                                  context.read<expenseBloc>().add(getInitialExpEvent(type: 1));
                                }
                                if(value == "Month wise"){
                                  context.read<expenseBloc>().add(getInitialExpEvent(type: 2));
                                }
                                if(value == "Year wise"){
                                  context.read<expenseBloc>().add(getInitialExpEvent(type: 3));
                                }
                                if(value == "Category wise"){
                                  context.read<expenseBloc>().add(getInitialExpEvent(type: 4));
                                }
                              },
                              textStyle: TextStyle(fontSize: 14,fontFamily: "Poppins",fontWeight: FontWeight.bold),
                              initialSelection: selectedFilterType,
                              dropdownMenuEntries: mExpenseFilterType.map((element) {
                                return DropdownMenuEntry(value: element, label: element);
                              }).toList(),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          height: 150,
                          padding: const EdgeInsets.only(
                              left: 20, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff6674D3)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Expense total", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white),),
                                  Text("\$3,734", style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white),),
                                  Row(
                                    children: [
                                      Container(

                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                5),
                                            color: Colors.red
                                        ),
                                        child: Center(child: Text("+\$240",
                                          style: TextStyle(fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.white),)),
                                      ),
                                      Text(" than last month", style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                  "asset/image/monety_bg2.png", height: 93)
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(" Expense List", style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),),
                        SizedBox(height: 15,),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allFilteredExpenses.length,
                            itemBuilder: (_,index){
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 5, bottom: 5),
                                margin: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(allFilteredExpenses[index].type, style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black),),
                                        Text("\$${allFilteredExpenses[index].totalAmt}", style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black),),
                                      ],
                                    ),
                                    Divider(color: Colors.grey, thickness: 1,),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: allFilteredExpenses[index].mExpenses.length,
                                        itemBuilder: (_,childIndex){
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(AppConstants.mCat.where((eachCat){
                                                        return eachCat.id == allFilteredExpenses[index].mExpenses[childIndex].catId;
                                                      }).toList()[0].imgPath,height: 40,width: 40,),
                                                      SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(allFilteredExpenses[index].mExpenses[childIndex].title, style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14,
                                                              color: Colors.black),),
                                                          Text(allFilteredExpenses[index].mExpenses[childIndex].desc, style: TextStyle(
                                                              fontFamily: "Poppins",
                                                              fontSize: 12,
                                                              color: Colors.black),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text("-\$${allFilteredExpenses[index].mExpenses[childIndex].amt}", style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Poppins",
                                                      fontSize: 14,
                                                      color: Color(0xffE78BBC)),),
                                                ],
                                              ),
                                              SizedBox(height: 15,)
                                            ],
                                          );
                                        })


                                  ],
                                ),
                              );
                            }),

                      ],
                    ),

                  ),
                );
              }
              return Container();
            }
        ),

      ),
    );
  }



}