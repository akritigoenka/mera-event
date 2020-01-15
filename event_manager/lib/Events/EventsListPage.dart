import 'package:event_manager/Database/database2.dart';
import 'package:event_manager/Events/AddEventScreen.dart';
import 'package:event_manager/Events/EventsPage.dart';
import 'package:flutter/material.dart';

import 'EditEventScreen.dart';
import 'package:event_manager/Database/event item class.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}


class _EventListState extends State<EventList> {

  List _events=new List();

  _getallevents() async{
    var db = new DatabaseHelper();
    _events = await db.getAllEvents();
    this.setState(()=>{});
  }
  _deleteevent(int id) async{
    var db = new DatabaseHelper();
    await db.deleteEvent(id);
    print("deleted");
  }

//  _updateevent(MyEventItems thisevent) async{
//    var db = new DatabaseHelper();
//    await db.updateEvent(thisevent);
//  }

  @override
  initState() {
    super.initState();
    _getallevents();
  }
  Widget _buildEventList() {
//    print(_events);
//    return Container();
    return new GridView.builder(
        itemCount: _events.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          if(index < _events.length) {
          return _buildEventItem(_events[index]['EventName'], index, _events[index]["flag"]);
        }
        });
//
  }

  // Build a single Event item
  Widget _buildEventItem(String EventText, int index, int tickted) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
//
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            print("tapped");
            MyEventItems thisevent=MyEventItems.map(_events[index]);
            print(thisevent);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TabbedAppBarSample(event: thisevent),
              ),
            );
//            return TabbedAppBarSample(event: thisevent);
          },
          onLongPress: (){
            _promptEditorRemoveEventItem(index);
          },

          child: Stack(
            children: <Widget>[
//              Container(
//                decoration: new BoxDecoration(
//
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey.withOpacity(0.7),
//                      spreadRadius: 5,
//                      blurRadius: 7,
//                      offset: Offset(0, 4), // changes position of shadow
//
//                    ),
//                  ],
//                ),
//              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Container(
//                alignment: Alignment.center,
//                color: Theme.of(context).buttonColor,
                  color: Colors.orangeAccent.shade100,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: tickted==1?Image.asset("images/tickets.png"):Image.asset("images/wave.png"),
                      ),
                      Center(child: Text(EventText,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );

  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptEditorRemoveEventItem(int index) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: Column(
                children: <Widget>[
                  new Text('Do you want to delete',style:  TextStyle(fontSize: 18),),
                  new Text("\n ${_events[index]['EventName']} ?",style:  TextStyle(fontSize: 10, ),),
                ],
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                new FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => editevent(event:MyEventItems.map(_events[index])),
                        )
                    ).then((value) {
                      Navigator.of(context).pop();
                      _getallevents();
                    });
                  },
                  child: new Text('Edit',style:  TextStyle(fontSize: 20),),),
                new FlatButton(
                    child: new Text('No',style:  TextStyle(fontSize: 20),),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('Yes, delete!',style:  TextStyle(fontSize: 20),),
                    onPressed: () {
                      _deleteevent(_events[index]['id']);
//                      _removeEventItem(index);
                      _getallevents();
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//            title: new Text('Event List')
//      ),
      body:Stack(
        children: <Widget>[
        Center(
//          child: new Image.asset(
//          'images/event_background.jpg',
//          width: size.width,
//          height: size.height,
//          fit: BoxFit.fill,
//          ),
        ),
          _buildEventList(),
        ]
      ),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen(),
            ),
          ).then((value) {
            _getallevents();
            });
            },


          tooltip: 'Add Event',
          child: new Icon(Icons.add)
    ),
    );
  }

}


