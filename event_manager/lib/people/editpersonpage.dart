import 'package:event_manager/Database/database2.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import 'package:event_manager/Database/event item class.dart';

class editperson extends StatefulWidget {
  final people invitee;
  final MyEventItems event;
  editperson({Key key,@required this.invitee,@required this.event}) : super(key: key);
  @override
  editpersonState createState() => editpersonState(invitee,event);
}


class editpersonState extends State<editperson> {
  final _formKey1 = GlobalKey<FormState>(
  );
  final people invitee;
  final MyEventItems event;

  editpersonState(this.invitee, this.event);

//  print(DateFormat("dd-MM-yyyy").format(now));


  @override
  Widget build(BuildContext context) {
    Widget _amountpaid(bool paid) {
      if (paid == true) {
        return Padding(
          padding: const EdgeInsets.all(
              8.0),
          child: TextFormField(
            initialValue: invitee.AmountPaid.toString(
            ),
            decoration:
            InputDecoration(
                labelText: 'Amount Paid'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'How much did they pay?';
              }
              if (!isFloat(
                  value)) {
                return "Please enter a valid amount";
              }
              if (double.parse(
                  value) < 0) {
                return "Amount cannot be negative";
              }
            },
            onSaved: (val) =>
                setState(
                        () {
                      invitee.AmountPaid = double.parse(
                          val);
                      print(
                          invitee.AmountPaid);
                    }),
          ),
        );
      } else {
        return Text(
            "");
      }
    }
    print(
        "entered add person");
//    invitee.Confirmation=false;
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
                              //Person name----------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    initialValue: invitee.Name,
                                    maxLength: 15,
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Name'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Who is invited?';
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(
                                              () => invitee.Name = val);
                                      print(
                                          invitee.Name);
                                    }

                                ),
                              ),
//                              ---------------------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    initialValue: invitee.plus.toString(
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Coming with (Number of people)'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Accompanied with..';
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(
                                              () =>
                                          invitee.plus = int.parse(
                                              val));
                                      print(
                                          invitee.plus);
                                    }

                                ),
                              ),
//                              Contact No.---------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    initialValue: invitee.ContactNo.toString(
                                    ),
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Contact No.'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter the contact number';
//                                      }
                                      if (!isInt(
                                          value)) {
                                        return "Please enter a valid number";
                                      }
                                      if (double.parse(
                                          value) < 0) {
                                        return "Contact cannot be negative";
                                      }
                                    },

                                    onSaved: (val) {
                                      print(
                                          val.length);
                                      setState(
                                              () =>
                                          invitee.ContactNo = int.parse(
                                              val));
                                      print(
                                          invitee.contactno);
                                    }
                                ),
                              ),
                              //---------------------------------------------
                              event.eventticketed == false ? CheckboxListTile(
                                title: Text(
                                    "Check if you get the confirmation/ RSVP?"),
                                value: invitee.Confirmation,
                                onChanged: (val) {
                                  setState(
                                          () {
                                        invitee.Confirmation = val;
                                      });
                                },
                              ) :
                              // if not ticketed
                              Column(
                                  children: [
                                    CheckboxListTile(
                                      title: Text(
                                          "Check if they paid for the tickets"),
                                      value: invitee.Paid,
                                      onChanged: (val) {
                                        setState(
                                                () {
                                              invitee.Paid = val;
                                            });
                                        print(
                                            invitee.paid);
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "Tickets collected?"),
                                      value: invitee.Received,
                                      onChanged: (val) {
                                        setState(
                                                () {
                                              invitee.Received = val;
                                            });
                                        print(
                                            invitee.received);
                                      },
                                    ),

                                  ]),
                              _amountpaid(
                                  invitee.paid),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 16.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        final form = _formKey1.currentState;
                                        if (form.validate(
                                        )) {
                                          form.save(
                                          );
                                          _updateInvitee(
                                              invitee);
                                          _showDialog(
                                              context);
                                          Navigator.pop(
                                              context);
//                                          Navigator.push(
//                                            context,
//                                            MaterialPageRoute(
//                                              builder: (context) => MainActivity(),
//                                            ),
//                                          );
                                        }
                                      },
                                      child: Text(
                                          'Done!'))),
                            ]),
                      )))),
    );
  }


  _updateInvitee(people invitee) async {
    var db = new DatabaseHelper(
    );
    await db.updatePerson(
        invitee);
  }

//
  _showDialog(BuildContext context) {
    Scaffold.of(
        context)
        .showSnackBar(
        SnackBar(
            content: Text(
                'Added Invitee')));
  }
}