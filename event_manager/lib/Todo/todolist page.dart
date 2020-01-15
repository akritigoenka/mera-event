import 'package:event_manager/Database/database2.dart';
import 'package:event_manager/Database/event%20item%20class.dart';
import 'package:flutter/material.dart';

import 'add item page.dart';

class ToDoList extends StatefulWidget {
  final MyEventItems event;
  ToDoList({Key key, @required this.event,}) : super(key: key);
  @override
  _ToDoListState createState() => _ToDoListState(this.event);
}

class _ToDoListState extends State<ToDoList> {
  todo item=todo();
  MyEventItems event;
  _ToDoListState(this.event);
  //-------------------------------------------------------------------
  List _todoItems=new List();

  _getallitems() async{
    var db = new DatabaseHelper();
    _todoItems = await db.getAllItems(event.ID==null?0:event.ID);
    this.setState((){});
    print("Items list:");
    print(_todoItems);
  }

  _deleteitem(int id) async{
    var db = new DatabaseHelper();
    await db.deleteItem(id);
    _getallitems();
    print("deleted");
  }

//  _updateitem(people person) async{
//    var db = new DatabaseHelper();
//    await db.updateItem(person);
//  }

  @override
  initState() {
    super.initState();
    _getallitems();
  }
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]["todoitem"], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return MaterialButton(
      child: Align(
          alignment: Alignment.centerLeft
          ,child: new Text(todoText)),
      onPressed: (){_promptRemoveTodoItem(index);},
      color: Colors.grey.shade50,
    );

  }
  //---------------------------------------------------------------------

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark \n${_todoItems[index]['todoitem']} \nas done?/Delete', style: TextStyle(fontSize: 15),),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(

                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _deleteitem(_todoItems[index]['id']);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }
//----------------------------------------------------------------------







  @override
  Widget build(BuildContext context) {
      return new Scaffold(
//        appBar: new AppBar(
//            title: new Text('Todo List')
//        ),
        body: _buildTodoList(),
          floatingActionButton: new FloatingActionButton(
              backgroundColor: Theme.of(context).bottomAppBarColor,
            onPressed: (){

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItemtoScreen(event: event, item: item),
                ),
              ).then((value) {
                _getallitems();
              });
            },
            tooltip: 'Add task',
            child: new Icon(Icons.add)
        ),
      );
    }


}