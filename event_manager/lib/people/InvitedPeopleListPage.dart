import 'package:event_manager/Database/database2.dart';
import 'package:event_manager/Database/event%20item%20class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addpersonpage.dart';
import 'editpersonpage.dart';


class PeopleList extends StatefulWidget {
  final MyEventItems event;
  PeopleList({Key key, @required this.event,}) : super(key: key);
  @override
  PeopleListState createState() => PeopleListState(this.event);
}


class PeopleListState extends State<PeopleList> {
  people insan=people();

  MyEventItems event;
  PeopleListState(this.event);
  List peoplelist=new List();

  _getallinvitees() async{
    var db = new DatabaseHelper();
    peoplelist = await db.getAllInvitees(event.ID);
    this.setState((){});
    print("people list:");
    print(peoplelist);
  }

  _deleteperson(int id) async{
    var db = new DatabaseHelper();
    await db.deletePerson(id);
    print("deleted");
  }



  @override
  initState() {
    super.initState();
    _getallinvitees();
  }
  Widget _buildPeopleList() {
    print(peoplelist);
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < peoplelist.length) {
          return _buildPerson(peoplelist[index]['Name'],peoplelist[index]['plus'],peoplelist[index]['Confirmationflag'],peoplelist[index]['Paidflag'],peoplelist[index]['Receivedflag'], index);
        }
      },
    );
//
  }

  // Build a single Event item
  Widget _buildPerson(String Persontext,int members, int confirmation,int paid,int received ,int index) {

    return Padding(
        padding: const EdgeInsets.all(2.0),
//
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            print("tapped");
            people person=people.map(peoplelist[index]);
            print(person);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => editperson(invitee:people.map(peoplelist[index]),event: event),
                )
            ).then((value) {
              _getallinvitees();
            });
          },
          onLongPress: (){
            _promptRemovePerson(index);
            _getallinvitees();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8,bottom: 8),
            child: Container(
              decoration:BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
//            color: Theme.of(context).buttonColor,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(Persontext,style: TextStyle(fontSize: 25),)),
                          Expanded(child: Text(""),),
                          Text(" + $members",style: TextStyle(fontSize: 25),),
                        ],
                      ),

                      event.eventticketed==false?
                      Row(
                        children: <Widget>[
                          Text("RSVP: ",style: TextStyle(color: Colors.grey),),
                          confirmation==1?Icon(Icons.check,color: Colors.green):Icon(Icons.close,color: Colors.red,),
                        ],
                      ):Row(
                        children: <Widget>[
                          Text("Paid:",style: TextStyle(color: Colors.grey),),
                          paid==1?Icon(Icons.check,color: Colors.green):Icon(Icons.close,color: Colors.red,),
                          Expanded(child:Text("")),
                          Text("Tickets Collected:",style: TextStyle(color: Colors.grey),),
                          received==1?Icon(Icons.check,color: Colors.green):Icon(Icons.close,color: Colors.red,),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ),
          ),
        )
    );

  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemovePerson(int index) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: Column(
                children: <Widget>[
                  new Text('Do you want to delete this invitee?',style:  TextStyle(fontSize: 18),),
//                  new Text("\n ${peoplelist[index]} ?",style:  TextStyle(fontSize: 10),),
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
                      _deleteperson(peoplelist[index]['id']);
                      _getallinvitees();
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  int _countPeopleIf(String condition){
    int count=0;
    for(int i=0;i<peoplelist.length;i++){
      if(peoplelist[i][condition]!=0){
        count++;
      }
    }
    return count;
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
//              child: new Image.asset(
//                'images/event_background.jpg',
//                width: size.width,
//                height: size.height,
//                fit: BoxFit.fill,
//              ),
            ),
            _buildPeopleList(),

          ]
      ),
//      bottomSheet: Text("hi "),
      bottomNavigationBar: Container(child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Total: ${peoplelist.length}"),
          Expanded(child: Text(""),),
          event.eventticketed==false?
          Text("RSVP: ${_countPeopleIf('Confirmationflag')}"):
          Text("Paid: ${_countPeopleIf('Paidflag')}"),
          Expanded(child: Text(""),),
          event.eventticketed==false?
              Text(""):
          Text("Collected: ${_countPeopleIf('Receivedflag')}")

        ],
      )),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          onPressed: (){

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPersonScreen(event: event, invitee: insan),
              ),
            ).then((value) {
              _getallinvitees();
            });
          },


          tooltip: 'Add Event',
          child: new Icon(Icons.add)
      ),
    );
  }

}
