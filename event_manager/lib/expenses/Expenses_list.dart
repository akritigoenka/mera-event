import 'package:event_manager/Database/database2.dart';
import 'package:event_manager/Database/event%20item%20class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addexpense.dart';
import 'editExpense.dart';


class ExpenseList extends StatefulWidget {
  final MyEventItems event;
  ExpenseList({Key key, @required this.event,}) : super(key: key);
  @override
  ExpenseListState createState() => ExpenseListState(this.event);
}


class ExpenseListState extends State<ExpenseList> {
  expenses expense=expenses();

  MyEventItems event;
  ExpenseListState(this.event);
  List expenselist=new List();

  _getallexpenses() async{
    var db = new DatabaseHelper();
    expenselist = await db.getAllexpenses(event.ID);
    this.setState((){});

//    print("Expense list:");
//    print(expenselist);
//    double sum=0;
//    for(int i=0;i<expenselist.length;i++)
//    {
//      print(expenselist[i]['cost']);
//      sum=sum + double.parse(expenselist[i]['cost']);
//    }
//    print(sum.toString());
  }

  _deleteExpense(int id) async{
    var db = new DatabaseHelper();
    await db.deleteExpense(id);
    print("deleted");
  }

//  _sumExpenses(expenses expense) async{
//    var db = new DatabaseHelper();
//    var sum= await db.getexpenseSum(event);
//    print(sum);
//    return sum;
//  }

  @override
  initState() {
    super.initState();
    _getallexpenses();
//    double sum=0;
//    for(int i=0;i<expenselist.length;i++)
//    {
//      print(expenselist[i]['cost']);
//      sum=(sum + double.parse(expenselist[i]['cost']));
//    }
//    print(sum);
  }
  Widget _buildExpenseList() {
    print(expenselist);
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < expenselist.length) {
          return _buildExpense(expenselist[index]['cost'],expenselist[index]['spenton'], index);
        }
      },
    );
//
  }

  // Build a single Event item
  Widget _buildExpense(double cost,String spentOn, int index) {

    return Padding(
        padding: const EdgeInsets.all(2.0),
//
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            print("tapped");
            expenses Expense=expenses.map(expenselist[index]);
            print(Expense);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => editExpense(expense:expenses.map(expenselist[index]),event: event),
                )
            ).then((value) {
              _getallexpenses();
            });
          },
          onLongPress: (){
            _promptRemoveExpense(index);
            _getallexpenses();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8,bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: <Widget>[
                      Text(spentOn,style: TextStyle(fontSize: 15),),
                      Expanded(child: Text(""),),
                      Text(cost.toString(),style: TextStyle(fontSize: 15),),
                    ],
                  ),
                ),
              ),
            ),
            ),
          ),
        );

  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveExpense(int index) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: Column(
                children: <Widget>[
                  new Text('Do you want to delete',style:  TextStyle(fontSize: 18),),
                  new Text("\n ${expenselist[index]} ?",style:  TextStyle(fontSize: 10),),
                ],
              ),
              backgroundColor: Colors.white70,
              actions: <Widget>[
                new FlatButton(
                    child: new Text('No',style:  TextStyle(fontSize: 20),),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('Yes, delete!',style:  TextStyle(fontSize: 20),),
                    onPressed: () {
                      _deleteExpense(expenselist[index]['id']);
                      _getallexpenses();
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

//  double calculate_expense(){
//    double expense=0;
//    print("entered calculate");
//    for(int i;i< expenselist.length;i++){
//      expense=expense+expenselist[i]["cost"];
//      print(expense);
//    }
//    return expense;
//  }

  @override
  Widget build(BuildContext context) {
//    double totalexpense=calculate_expense();
    return new Scaffold(
//      appBar: new AppBar(
//            title: new Text('Event List')
//      ),
      body:_buildExpenseList(),
//      bottomSheet: Text("hi "),
      bottomNavigationBar: Container(child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Budget: ${event.eventbudget}"),
          Expanded(child: Text(""),),
//          Text("Spent: ${totalexpense}"),
        ],
      )),

      floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          heroTag: "btn1",
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpenseScreen(event: event,expense: expense,),
              ),
            ).then((value) {
              _getallexpenses();
            });

          print("Pressed add expense button");
          },
          tooltip: 'Add Event',
          child: new Icon(Icons.add)
      ),
    );
  }

}
