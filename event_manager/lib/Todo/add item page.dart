import 'package:event_manager/Database/database2.dart';
import 'package:flutter/material.dart';
import 'package:event_manager/Database/event item class.dart';

class AddItemtoScreen extends StatefulWidget {
  final MyEventItems event;
  final todo item;
  AddItemtoScreen({Key key, @required this.event,@required this.item}) : super(key: key);
  @override
  AddItemtoScreenState createState() => AddItemtoScreenState(event,item);
}


class AddItemtoScreenState extends State<AddItemtoScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final MyEventItems event;
  final todo item;
  AddItemtoScreenState(this.event,this.item);


  @override
  Widget build(BuildContext context) {
    print("entered add item");
//    invitee.Confirmation=false;
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Add Task')),
      body: Container(
          color: Colors.white70,
          child: Builder(
              builder: (context) =>
                  Form(
                      key: _formKey1,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(
                                  8.0),
                              child: TextFormField(
                                  maxLength: 30,
                                  decoration:
                                  InputDecoration(labelText: 'Task'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Forgetting anything??';
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(
                                            () => item.Item = val);
                                    print(item.Item);
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
                                          _saveItem(item);
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
  _saveItem(todo item) async{
    var db = new DatabaseHelper();
    item.eventid=(event==null)?0:event.id;
//    item.eventid=event.id;
    int saveditem = await db.saveItem(item);
    print("todo item $saveditem ${item.item}");
  }
}
//
_showDialog(BuildContext context) {
  Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Added Invitee')));
}