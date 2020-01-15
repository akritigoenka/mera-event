import 'package:event_manager/Database/database2.dart';
import 'package:flutter/material.dart';
import 'package:event_manager/Database/event item class.dart';

class AddExpenseScreen extends StatefulWidget {
  final MyEventItems event;
  final expenses expense;
  AddExpenseScreen({Key key, @required this.event,@required this.expense}) : super(key: key);
  @override
  AddExpenseScreenState createState() => AddExpenseScreenState(event,expense);
}

class AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey2 = GlobalKey<FormState>();
  final MyEventItems event;
  final expenses expense;
  AddExpenseScreenState(this.event,this.expense);

  @override
  Widget build(BuildContext context) {
    print("entered add expense");
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Add Expense')),
      body: Container(
          color: Colors.white70,
          child: Builder(
              builder: (context) =>
                  Form(
                      key: _formKey2,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    maxLength: 15,
                                    decoration:
                                    InputDecoration(labelText: 'Spent on?'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'What did you spend on?';
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(
                                              () => expense.spentOn = val);
                                      print(expense.spentOn);
                                    }

                                ),
                              ),
                              //Expense ----------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    maxLength: 15,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                    InputDecoration(labelText: 'Expense'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'How much did you spend?';
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(
                                              () => expense.cost = double.parse(val));
                                      print(expense.cost);
                                    }

                                ),
                              ),
                              //---------------------------------------------

                              Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        final form = _formKey2.currentState;
                                        if (form.validate()) {
                                          form.save();
                                          _saveExpense(expense);
                                          _showDialog(context);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text('Add'))),
                            ]),
                      )))),
    );
  }
  _saveExpense(expenses expense) async{
    var db = new DatabaseHelper();
    expense.eventid=event.id;
    int savedPerson = await db.saveExpense(expense);
    print("saved person $savedPerson ${expense.cost}");
  }
}
//
_showDialog(BuildContext context) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Added Expense')));
}