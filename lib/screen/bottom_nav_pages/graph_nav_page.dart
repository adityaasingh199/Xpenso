import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpenso/data/model/filter_expense_model.dart';
import 'package:xpenso/espense/expense_bloc.dart';
import 'package:xpenso/espense/expense_event.dart';
import 'package:xpenso/espense/expense_state.dart';

class graphBottomPage extends StatefulWidget{

  @override
  State<graphBottomPage> createState() => _graphBottomPageState();
}

class _graphBottomPageState extends State<graphBottomPage> {


  @override
  void initState() {
    super.initState();
    context.read<expenseBloc>().add(getInitialExpEvent(type:1));
  }

  @override
  Widget build(BuildContext context) {
    int xCount = 0;
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(" Statistic",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black),),

                    Container(
                      width: 105,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0x1b194cff)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(" This Month",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
                          Icon(Icons.expand_more_rounded,size: 20,)
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 130,
                  padding: const EdgeInsets.only(left: 20,top: 5,bottom: 8,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xdd6674d3)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total expense",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white),),
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Color(0x47ffffff)
                            ),
                            child: Icon(Icons.more_horiz_rounded,color: Colors.white,size: 25,),
                          )
                        ],
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("\$3,734",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                          Text("  /\$4000 per month",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.w300,fontSize: 12,color: Color(
                              0xabffffff)),),
                        ],
                      ),
                      Container(
                          height: 8,
                          width: double.infinity,
                          padding: EdgeInsets.only(right: 50),
                          decoration: BoxDecoration(
                            color: Color(0xef6674d3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffEAC794),
                              borderRadius: BorderRadius.circular(5),
                            ),

                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" Expense Breakdown",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                        Text(" Limit \$900 / week",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.w500,fontSize: 14,color: Color(
                            0xcb000000)),),

                      ],
                    ),
                    Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0x1b194cff)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(" Week",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
                          Icon(Icons.expand_more_rounded,size: 20,)
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),

                BlocBuilder<expenseBloc,expenseState>(
                    builder: (context,state){
                  if(state is expenseLoadingState){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(state is expenseErrorState){
                    return Center(child: Text(state.errorMsg),);
                  }
                  if(state is expenseLoadedState){
                    List<filterExpenseModel> mData = state.allExpenses;
                    return SizedBox(
                        height: 250,
                        child: BarChart(
                            BarChartData(
                                borderData: FlBorderData(show: false),
                                titlesData: FlTitlesData(
                                    rightTitles: AxisTitles(),
                                    bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            /*getTitlesWidget: (value, meta) {
                                            final match = mData.firstWhere((element)=> element.mExpenses == value);
                                              return Text(match.type);
                                            },*/
                                            showTitles: true
                                        )
                                    ),
                                    topTitles: AxisTitles()
                                ),
                                gridData:FlGridData(
                                  show: false,
                                ),
                                barGroups: mData.map((element){
                                  xCount++;
                                  return BarChartGroupData(x:xCount,
                                      barRods: [
                                    BarChartRodData(toY: element.totalAmt.toDouble()<0 ? element.totalAmt.toDouble()*-1:element.totalAmt.toDouble(),
                                      color: Colors.blue,width: 21,
                                      //borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                                      )
                                  ]);
                                }).toList()
                            )
                        )
                      /*Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffDB6564)
                                ),
                                child: Center(child: Text("\$900",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Colors.white),)),
                              ),
                              Text("\$900",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000))),
                              Text("\$600",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000))),
                              Text("\$300",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000))),
                              Text("\$0",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000))),
                              SizedBox(height: 1,)

                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 135,
                                width: 42,
                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff67C2DC)
                                ),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("\$640",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Colors.white),)),
                              ),
                              SizedBox(height: 5,),
                              Text("W1",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000)),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 150,
                                width: 42,
                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff67C2DC)
                                ),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("\$640",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Colors.white),)),
                              ),
                              SizedBox(height: 5,),
                              Text("W2",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000)),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 120,
                                width: 42,
                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff67C2DC)
                                ),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("\$640",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Colors.white),)),
                              ),
                              SizedBox(height: 5,),
                              Text("W3",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000)),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 177,
                                width: 42,
                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xffDB6564)
                                ),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("\$640",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Colors.white),)),
                              ),
                              SizedBox(height: 5,),
                              Text("W4",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000)),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 145,
                                width: 45,
                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff67C2DC)
                                ),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text("\$640",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Colors.white),)),
                              ),
                              SizedBox(height: 5,),
                              Text("W5",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 11,color: Color(0xcb000000)),)
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        top: 9,
                        right: 0,
                        child: Container(
                            height: 3,
                            width: 295,
                            color: Color(0xffDB6564)
                        ),
                      ),

                    ],
                  ),*/
                    );
                  }
                  return Container();
                }),


                SizedBox(height: 15,),
                Text("Spending Details",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
                //SizedBox(height: 5,),
                Text("Your expenses are divided into 6 catgories",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Color(
                    0xB6000000)),),
                SizedBox(height: 15,),


                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Container(
                        width: 90,
                        height: 11,
                        decoration: BoxDecoration(
                            color: Color(0xff6574D1),
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(3))
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        height: 11,
                        color: Color(0xffE78BBC),
                      ),
                    ),
                    Expanded(
                      flex: 18,
                      child: Container(
                        height: 11,
                        color: Color(0xffEBC68C),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Container(
                        height: 11,
                        color: Color(0xff67C2DA),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        height: 11,
                        color: Color(0xffDA6562),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        height: 11,
                        decoration: BoxDecoration(
                            color: Color(0xff6574D1),
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(3))
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Container(
                        child: Text("40%",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Color(
                            0xe0000000)),),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        child: Text("25%",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Color(
                            0xe0000000)),),
                      ),
                    ),
                    Expanded(
                      flex: 18,
                      child: Container(
                        child: Text("15%",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Color(
                            0xe0000000)),),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: Container(
                        child: Text("10%",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Color(
                            0xe0000000)),),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: Text("5%",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Color(
                            0xe0000000)),),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        child: Text("5%",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 12,color: Color(
                            0xe0000000)),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 75,
                        padding: const EdgeInsets.only(left: 12,right: 20,top: 12,bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0x5c6674d3)
                              ),
                              child: Icon(Icons.shopping_cart_outlined,size: 20,color: Color(0xff6674D3)),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Shop",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                Text("-\$1190",style: TextStyle(fontWeight: FontWeight.bold,fontFamily:"Poppins",fontSize: 14,color: Color(0xffE78BBC)),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                    Expanded(
                      child: Container(
                        height: 75,
                        padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0x56c76364)
                              ),
                              child: Icon(Icons.emoji_transportation,size: 20,color: Color(0xffC76364)),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Transport",overflow:TextOverflow.ellipsis,style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                Text("-\$867",style: TextStyle(fontWeight: FontWeight.bold,fontFamily:"Poppins",fontSize: 14,color: Color(0xffE78BBC)),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 75,
                        padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0x6be2caaa)
                              ),
                              child: Icon(Icons.phone_android_rounded,size: 20,color: Color(
                                  0xfff3c589)),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Electronics",overflow:TextOverflow.ellipsis,style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                Text("-\$1290",style: TextStyle(fontWeight: FontWeight.bold,fontFamily:"Poppins",fontSize: 14,color: Color(0xffE78BBC)),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                    Expanded(
                      child: Container(
                        height: 75,
                        padding: const EdgeInsets.only(left: 12,right: 20,top: 12,bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0x5c6674d3)
                              ),
                              child: Icon(Icons.shopping_cart_outlined,size: 20,color: Color(0xff6674D3)),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Shop",style: TextStyle(fontFamily:"Poppins",fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                Text("-\$1190",style: TextStyle(fontWeight: FontWeight.bold,fontFamily:"Poppins",fontSize: 14,color: Color(0xffE78BBC)),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}