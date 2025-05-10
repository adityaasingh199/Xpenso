import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xpenso/screen/bottom_nav_pages/app_expense.dart';
import 'package:xpenso/screen/bottom_nav_pages/graph_nav_page.dart';
import 'package:xpenso/screen/bottom_nav_pages/home_nav_page.dart';
import 'package:xpenso/screen/bottom_nav_pages/notification_nav_page.dart';
import 'package:xpenso/screen/bottom_nav_pages/profile_nav_page.dart';

class homePage extends StatefulWidget{
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> navPages =[
    homeBottomPage(),
    graphBottomPage(),
    notificationBottomPage(),
    profileBottomPage()
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:navPages[_selectedIndex],

      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        color: Colors.white,
        shadowColor: Colors.black,
        //shape: CircularNotchedRectangle(), // Creates a notch for FAB
        //notchMargin: 0, // Space around the FAB
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined,size: 30,color: _selectedIndex==0 ?Color(0xffE78BBC) : Colors.grey,),
              onPressed: () => onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.bar_chart_outlined,size: 30,color: _selectedIndex==1 ?Color(0xffE78BBC) : Colors.grey,),
              onPressed: () => onItemTapped(1),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>addExpense()));
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffE78BBC)
                ),
                child: Icon(Icons.add,color: Colors.white,size: 27,),
              ),
            ), // Space for the FAB
            IconButton(
              icon: Icon(Icons.notifications_none_outlined,size: 30,color: _selectedIndex==2 ?Color(0xffE78BBC) : Colors.grey,),
              onPressed: () => onItemTapped(2),
            ),
            IconButton(
              icon: Icon(Icons.account_circle_outlined,size: 30,color: _selectedIndex==3 ?Color(0xffE78BBC) : Colors.grey,),
              onPressed: () => onItemTapped(3),
            ),
          ],
        ),
      ),
     );
  }
}