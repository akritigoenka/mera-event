import 'package:event_manager/Database/database2.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

import 'package:event_manager/Database/event item class.dart';

class editevent extends StatefulWidget {
  final MyEventItems event;
  editevent({Key key, @required this.event}) : super(key: key);

  @override
  editeventState createState() { return editeventState(this.event);}

}

class editeventState extends State<editevent> {
  final _formKey = GlobalKey<FormState>();

//  print(DateFormat("dd-MM-yyyy").format(now));
  MyEventItems _event = MyEventItems();
  editeventState(this._event);
//  final datetimeFormat= DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")
  final datetimeFormat= DateFormat("dd-MM-yyyy");



  //ticket price function
  Widget ticketprice(bool eventtype) {
    if (eventtype == true) {
      return Padding(
        padding: const EdgeInsets.all(
            8.0),
        child: TextFormField(
          initialValue: _event.TicketPrice.toString(),
          decoration:
          InputDecoration(
              labelText: 'Ticket\'s price',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {

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
                    if(val==null){
                      _event.TicketPrice = double.parse(
                          val);
                    }
                    print(
                        _event.TicketPrice);
                  }),
        ),
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("entered editevent pag widget");
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Edit Event ${_event.EventName}')),
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
                                  initialValue: _event.EventName,
                                    decoration:
                                    InputDecoration(
                                      labelText: 'Event name',

                                    ),

                                    onSaved: (val) {
                                      setState(
                                              (){
                                                  _event.EventName = val;
                                              });
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
                                  initialValue: _event.EventBudget.toString(),
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Budget',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {

                                      if(!isFloat(value)){
                                        return "Please enter a valid amount";
                                      }
                                      if (double.parse(
                                          value) < 0) {
                                        return "Amount cannot be negative";
                                      }

                                    },

                                    onSaved: (val) {
                                      setState(() {
                                          _event.EventBudget = double.parse(val);}
                                          );
                                      print(_event.EventBudget);
                                    }
                                ),
                              ),
                              //---------------------------------------------

                              //Date and time of event
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: DateTimePickerFormField(
                                  initialValue: datetimeFormat.parse("${_event.day}-${_event.month}-${_event.year}"),
//                                  inputType: InputType.both,
                                  inputType: InputType.date,
                                  validator: (date){
                                    if(date.isBefore(DateTime.now())){
                                      return 'Seems like you entered a past date';
                                    }
                                  },
                                  format: datetimeFormat,
                                  editable: false,
                                  decoration: InputDecoration(
                                      labelText: 'Date',
                                      hasFloatingPlaceholder: false
                                  ),
                                  onChanged: (date) {
                                    setState((){_event.setdate(date.day, date.month, date.year);});
                                    print('Selected date: ${_event.day}/${_event.month}/${_event.year}');
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
//                              -------------------------------------------

                              ticketprice(_event.EventTicketed),

                              Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        final form = _formKey.currentState;
                                        if (form.validate()) {
                                          form.save();
                                          _event.save();
                                          _updateevent(_event);
                                          print("updated");
                                          _showDialog(context);
                                          Navigator.of(context).pop();
//
                                        }
                                      },
                                      child: Text('Save changes'))),
                            ]),
                      )))),
    );
  }

}

_updateevent(MyEventItems thisevent) async{
  var db = new DatabaseHelper();
  await db.updateEvent(thisevent);
}

_showDialog(BuildContext context) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Edited your Event')));
}