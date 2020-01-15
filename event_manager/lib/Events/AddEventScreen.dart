import 'package:event_manager/Database/database2.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

import 'package:event_manager/Database/event item class.dart';

class AddEventScreen extends StatefulWidget {
//  final int index;
//  AddEventScreen({Key key, @required this.index}) : super(key: key);
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();

//  print(DateFormat("dd-MM-yyyy").format(now));
  final _event = MyEventItems();
//  final datetimeFormat= DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")
  final datetimeFormat= DateFormat("dd-MM-yyyy");

  //ticket price function
  Widget ticketprice(bool eventtype) {
    if (eventtype == true) {
      return Padding(
        padding: const EdgeInsets.all(
            8.0),
        child: TextFormField(
          decoration:
          InputDecoration(
              labelText: 'Ticket\'s price'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty) {
              return 'What amount are you charging per person?';
            }
            if(!isFloat(value)){
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
                    _event.TicketPrice = double.parse(
                        val);
                    print(
                        _event.TicketPrice);
                  }),
        ),
      );
    } else {
      return Text(          "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Add Event')),
      body: Container(
        color: Colors.white70,
          child: Builder(
              builder: (context) =>
                  Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //Event name----------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Event name'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'What is your Event called?';
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(
                                              () => _event.EventName = val);
                                      print(
                                          _event.EventName);
                                    }

                                ),
                              ),
                              //---------------------------------------------
                              //Event Budget---------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    initialValue: '0',
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Budget'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter the amount you\'re spending on the event';
//                                      }
                                      if(!isFloat(value)){
                                        return "Please enter a valid amount";
                                      }
                                      if (double.parse(
                                          value) < 0) {
                                        return "Amount cannot be negative";
                                      }

                                    },

                                    onSaved: (val) {
                                      setState(() =>
                                          _event.EventBudget = double.parse(
                                              val));
                                      print(
                                          _event.EventBudget);
                                    }
                                ),
                              ),
                              //---------------------------------------------

                              //Date and time of event
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: DateTimePickerFormField(
//                                  inputType: InputType.both,
                                inputType: InputType.date,
                                  format: datetimeFormat,
                                  editable: false,
                                  validator: (date){
                                    if (date==null) {
                                      return 'Please select the date of the event';
                                    }
                                    if(date.isBefore(DateTime.now())){
                                      return 'Seems like you entered a past date';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Date',
                                      hasFloatingPlaceholder: false
                                  ),
                                  onChanged: (date) {
                                  print("date changed");
                                    setState(() {
                                      _event.EventDate=date;
                                      _event.setdate(date.day, date.month, date.year);
                                    });
                                    print(_event.EventDate);
                                    print(
                                        'Selected date: ${_event.day}/${_event.month}/${_event.year}');
                                  },
                                ),
                              ),


                              //Event type[tickets charged or not]
//                              Container(
//                                padding: const EdgeInsets.all(10),
//                                child: Text('Event type'),
//                              ),
                              SwitchListTile(
                                  title: const Text('Tickets charged'),
                                  value: _event.EventTicketed,
                                  onChanged: (bool val) =>
                                      setState(
                                              () =>
                                          _event.EventTicketed = val
                                      )
                              ),
                              //Event type-----------------------------------
//                            Container(
//                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
//                              child: Text('Event Type'),
//                            ),
//                            CheckboxListTile(
//                                title: const Text('Check if you are charging tickets'),
//                                value: _event.EventType[MyEventItems.EventTicket],
//                                onChanged: (val) {
//                                  setState(() =>
//                                  _event.EventType[MyEventItems.EventTicket] = val);
//                                }),
                              //---------------------------------------------


                              ticketprice(_event.EventTicketed),

                              Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        final form = _formKey.currentState;
                                        if (form.validate()) {
                                          form.save();
                                          _event.save();
                                           _saveEvent();
                                          _showDialog(context);
                                          Navigator.of(context).pop();
//                                          Navigator.push(
//                                            context,
//                                            MaterialPageRoute(
//                                              builder: (context) => MainActivity(),
//                                            ),
//                                          );
                                        }
                                      },
                                      child: Text('Add this Event'))),
                            ]),
                      )))),
    );
  }
  _saveEvent() async{
    var db = new DatabaseHelper();
    await db.saveEvent(_event);
    print("saved");
  }
}

_showDialog(BuildContext context) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Added your Event')));
}