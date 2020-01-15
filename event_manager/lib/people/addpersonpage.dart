import 'package:event_manager/Database/database2.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:event_manager/Database/event item class.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class AddPersonScreen extends StatefulWidget {
  final MyEventItems event;
  final people invitee;
  AddPersonScreen({Key key, @required this.event,@required this.invitee}) : super(key: key);
  @override
  AddPersonScreenState createState() => AddPersonScreenState(event,invitee);
}

class AddPersonScreenState extends State<AddPersonScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final MyEventItems event;
  final people invitee;
  AddPersonScreenState(this.event,this.invitee);

  void fetch_contact_c_permission() async{
    print("checking permissions");
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    print("--- $permission");
    if(permission==PermissionStatus.granted)
      {
        Contact contact = await _contactPicker.selectContact();
        setState(() {
          _contact = contact;
        });
        print(_contact);
      }
    else {
      print("request permission");
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler(
      ).requestPermissions(
          [PermissionGroup.contacts]);
    }
  }

  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;

  @override
  Widget build(BuildContext context) {

    invitee.plus=0;
    Widget _amountpaid(bool paid) {
      if (paid == true) {
        return Padding(
          padding: const EdgeInsets.all(
              8.0),
          child: TextFormField(
            decoration:
            InputDecoration(
                labelText: 'Amount Paid'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'How much did they pay?';
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
                      invitee.AmountPaid = double.parse(
                          val);
                      print(
                          invitee.AmountPaid);
                    }),
          ),
        );
      } else {
        return Text(          "");
      }
    }
    print("entered add Guest");
//    invitee.Confirmation=false;
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Add Guest')),
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
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton.icon(onPressed: ()async {
                                  print("checking permissions");
//                                  print("checking permissions");
                                  PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
                                  print("--- $permission");
                                  if(permission==PermissionStatus.granted)
                                  {
                                    print("entered");
                                    Contact contact = await _contactPicker.selectContact();
                                    setState(() {
                                      _contact = contact;
                                    });
                                    print(_contact);
                                  }
                                  else {
                                    print("request permission");
                                    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler(
                                    ).requestPermissions(
                                        [PermissionGroup.contacts]);
                                  }
//                                  fetch_contact_c_permission;

                                },
                                  icon: Icon(Icons.contact_phone), label: Text("Contacts")),
                              ),
                              new Text(
                                _contact == null ? '   You can pick contacts from your phonebook' : _contact.toString(),
                              ),
                              //Person name----------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                  maxLength: 15,
                                    decoration:
                                    InputDecoration(labelText: 'Name'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Did you forget to mention the name of your guest?';
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(
                                              () => invitee.Name = val);
                                      print(invitee.Name);
                                    }

                                ),
                              ),
                              //------------------------------------------
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    initialValue: '0',
                                    keyboardType: TextInputType.number,
                                    decoration:
                                    InputDecoration(labelText: 'Coming with (Number of people)'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Is your guest coming with others? (put 0 if alone)';
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(
                                              () => invitee.plus = int.parse(val));
                                      print(invitee.plus);
                                    }

                                ),
                              ),
                              //----------------------------------contacts
                              Padding(
                                padding: const EdgeInsets.all(
                                    8.0),
                                child: TextFormField(
                                    decoration:
                                    InputDecoration(
                                        labelText: 'Contact No.'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter the contact number';
//                                      }
                                      if(!isInt(value)){
                                        return "Entering a valid contact will help you send reminders.\n Enter 0 if you don't wish to add contact.";
                                      }
                                      if (double.parse(
                                          value) < 0) {
                                        return "Contact cannot be negative";
                                      }

                                    },

                                    onSaved: (val) {
                                      print(val.length);
                                      setState(() =>
                                      invitee.ContactNo = int.parse(
                                          val));
                                      print(
                                          invitee.contactno);
                                    }
                                ),
                              ),
                              //---------------------------------------------
                              event.eventticketed==false? CheckboxListTile(
                                  title: Text("Check if you get the confirmation/ RSVP?"),
                                  value: invitee.Confirmation,
                                  onChanged: (val) {
                                    setState(() {
                                      invitee.Confirmation = val;
                                    });
                                  },
                                ):
                              // if not ticketed
                              Column(
                                  children: [
                                  CheckboxListTile(
                                  title: Text("Check if they paid for the tickets"),
                                  value: invitee.Paid,
                                  onChanged: (val) {
                                    setState(() {
                                      invitee.Paid = val;
                                    });
                                    print(invitee.paid);
                                  },
                                ),
                                    _amountpaid(invitee.paid),
                                //------------------------------------------------------------------------
                                CheckboxListTile(
                                  title: Text("Tickets collected?"),
                                  value: invitee.Received,
                                  onChanged: (val) {
                                    setState(() {
                                      invitee.Received = val;
                                    });
                                    print(invitee.received);
                                  },
                                )
                              ]),
//save------------------------------------------------------------------------------
                              Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                  child: RaisedButton(
                                      onPressed: () {
                                        final form = _formKey1.currentState;
                                        if (form.validate()) {
                                          form.save();
                                          _saveInvitee(invitee);
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
                                      child: Text('Add'))),
                            ]),
                      )))),
    );
  }
  _saveInvitee(people invitee) async{
    var db = new DatabaseHelper();
    invitee.eventid=event.id;
    int savedPerson = await db.saveInvitee(invitee);
    print("saved person $savedPerson ${invitee.name}");
  }
}
//
_showDialog(BuildContext context) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Added your Guest to the list')));
}