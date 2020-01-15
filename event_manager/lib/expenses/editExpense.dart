import 'package:event_manager/Database/database2.dart';
import 'package:flutter/material.dart';
import 'package:event_manager/Database/event item class.dart';

class editExpense extends StatefulWidget {
  final expenses expense;
  final MyEventItems event;
  editExpense({Key key,@required this.expense,@required this.event}) : super(key: key);
  @override
  editExpenseState createState() => editExpenseState(expense,event);
}

class editExpenseState extends State<editExpense> {
  final _formKey1 = GlobalKey<FormState>();
  final expenses expense;
  final MyEventItems event;
  editExpenseState(this.expense,this.event);

  @override
  Widget build(BuildContext context) {
    print("entered add person");
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Add Invited Person')),
      body: Container(
          color: Colors.white70,
          child: Builder(
              builder: (context) =>
                  Form(
                      key: _formKey1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    initialValue:expense.SpentOn ,
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
                              //Expense----------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    initialValue:expense.Cost.toString() ,
                                    maxLength: 15,
                                    decoration:
                                    InputDecoration(labelText: 'Expense'),
                                    keyboardType: TextInputType.number,
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

                              Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        final form = _formKey1.currentState;
                                        if (form.validate()) {
                                          form.save();
                                          _updateExpense(expense);
                                          _showDialog(context);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text('Done!'))),
                            ]),
                      )))),
    );
  }
}

_updateExpense(expenses expense) async{
  var db = new DatabaseHelper();
  await db.updateExpense(expense);
}

//
_showDialog(BuildContext context) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Added Invitee')));
}