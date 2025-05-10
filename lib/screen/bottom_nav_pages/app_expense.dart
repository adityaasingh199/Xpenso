import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xpenso/data/model/expense_model.dart';
import 'package:xpenso/domain/app_constants.dart';
import 'package:xpenso/espense/expense_bloc.dart';
import 'package:xpenso/espense/expense_event.dart';

class addExpense extends StatefulWidget {
  @override
  State<addExpense> createState() => _addExpenseState();
}

class _addExpenseState extends State<addExpense> {
  TextEditingController nameController = TextEditingController();

  TextEditingController amtController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  int selectedCatIndex = -1;
  @override
  List<String> mExpenseType = ["Debit", "Credit"];

  String selectedType = "Debit";

  DateTime? selectedDateTime;

  DateFormat formatter = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(11),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Name",
                  hintStyle: TextStyle(
                      fontFamily: "Poppins", fontSize: 17, color: Colors.grey)),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                  hintStyle: TextStyle(
                      fontFamily: "Poppins", fontSize: 17, color: Colors.grey)),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: amtController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Amount",
                  hintStyle: TextStyle(
                      fontFamily: "Poppins", fontSize: 17, color: Colors.grey)),
            ),
            SizedBox(
              height: 11,
            ),
            SizedBox(
              width: double.infinity,
              height: 57,
              child: OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 11,
                                      mainAxisSpacing: 11,
                                      crossAxisCount: 4),
                              itemCount: AppConstants.mCat.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedCatIndex = index;
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AppConstants.mCat[index].imgPath,
                                        height: 60,
                                      ),
                                      Text(AppConstants.mCat[index].name),
                                    ],
                                  ),
                                );
                              }),
                        );
                      });
                },
                child: selectedCatIndex >= 0
                    ? Row(
                        children: [
                          Image.asset(
                            AppConstants.mCat[selectedCatIndex].imgPath,
                            height: 45,
                            width: 45,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppConstants.mCat[selectedCatIndex].name,
                            style:
                                TextStyle(fontSize: 15, fontFamily: "Poppins"),
                          )
                        ],
                      )
                    : Text("Choose Category"),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(
              height: 11,
            ),

            ///DropDownButton

            /* DropdownButton(
                value: selectedType,
                items: mExpenseType.map((element){
              return DropdownMenuItem(
                  value: element,
                  child: Text(element));
            }).toList(), onChanged: (value){
              selectedType = value!;
              setState(() {

              });
            })*/

            ///DropDownMenu

            DropdownMenu(
              width: double.infinity,
              initialSelection: selectedType,
              dropdownMenuEntries: mExpenseType.map((element) {
                return DropdownMenuEntry(value: element, label: element);
              }).toList(),
            ),
            SizedBox(
              height: 11,
            ),
            SizedBox(
              width: double.infinity,
              height: 57,
              child: OutlinedButton(
                onPressed: () async {
                  selectedDateTime = await showDatePicker(
                      context: context,
                      firstDate:
                          DateTime.now().subtract(Duration(days: 365 * 2)),
                      lastDate: DateTime.now());

                  setState(() {});
                },
                child:
                    Text(formatter.format(selectedDateTime ?? DateTime.now())),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  if(selectedCatIndex!=-1){
                    context.read<expenseBloc>().add(addExpenseEvent(
                        newExp: expenseModel(
                            title: nameController.text,
                            desc: descriptionController.text,
                            amt: int.parse(amtController.text),
                            bal: 0,
                            catId: AppConstants.mCat[selectedCatIndex].id,
                            createdAt: (selectedDateTime ?? DateTime.now())
                                .millisecondsSinceEpoch
                                .toString(),
                            type: selectedType)));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add Expense",
                  style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
                ),
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
