import 'dart:ui';

import 'package:event_manager/Database/database2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import 'package:event_manager/Database/event item class.dart';

class EventList_forpeople extends StatefulWidget {
  @override
  _EventList_forpeopleState createState() => _EventList_forpeopleState();
}


class _EventList_forpeopleState extends State<EventList_forpeople> {
  List _events=new List();
  List peoplelist=new List();
  List<people> peoplenameList=new List();
  final pdf.Document doc = pdf.Document();

  _getallevents() async{
    var db = new DatabaseHelper();
    _events = await db.getAllEvents();
    this.setState((){});
  }

  _getallinvitees(MyEventItems event) async{
    var db = new DatabaseHelper();
    peoplelist = await db.getAllInvitees(event.ID);
    this.setState((){});
    print("people list:");
    print(peoplelist);
    for(int i=0;i<peoplelist.length;i++)
    {
      peoplenameList.add(people.map(peoplelist[i]));
      print(peoplelist[i]["Name"]);
//      peoplenameList.add(peoplelist[i].name);
    }
    print(peoplenameList);
    onclick_event(event.EventName);
  }

  List<int> make_doc(PdfPageFormat format) {

    doc.addPage(
      pdf.MultiPage(
        build: (context) => [
          pdf.Table.fromTextArray(context: context, data: <List<String>>[
            <String>["Names"],
            ...peoplenameList.map(
                    (peep) => [peep.name])
          ]),
        ],
      ),
    );
    return doc.save();
  }

  @override
  initState() {
    super.initState();
    _getallevents();
  }
  Widget _buildEventList() {
    return new GridView.builder(
        itemCount: _events.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          if(index < _events.length) {
            return _buildEventItem(_events[index]['EventName'], index);
          }
        });
//
  }

  // Build a single Event item
  Widget _buildEventItem(String EventText, int index) {

    return Padding(
        padding: const EdgeInsets.all(8.0),
//
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: ()async{
            print("tapped");
            MyEventItems thisevent=MyEventItems.map(_events[index]);
            _getallinvitees(thisevent);
            print(peoplelist.length);
//            peoplenameList='' as List;

          },

          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              color: Theme.of(context).buttonColor,
              child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("list from",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("\" $EventText\" ",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              )),
            ),
          ),
        )
    );

  }

  void onclick_event(String eventname) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: Column(
                children: <Widget>[
                  new Text(' $eventname ',style:  TextStyle(fontSize: 18),),
                ],
              ),
              backgroundColor: Colors.white70,
              actions: <Widget>[
                new FlatButton(
//                    child: new Text('Print',style:  TextStyle(fontSize: 20),),
                    child: Icon(Icons.print),
                    onPressed: () async{
                      await Printing.layoutPdf(
                          onLayout: make_doc);
                      Navigator.of(context).pop();
                    }
                ),
//                new FlatButton(
//                    child: new Text('Save',style:  TextStyle(fontSize: 20),),
//                    onPressed: ()async {
//                      final output = await getTemporaryDirectory();
//                      final file = File("${output.path}/${eventname}_List.pdf");
//                      await file.writeAsBytes(doc.save());
//                      Navigator.of(context).pop();
//                    }
//                ),
                new FlatButton(
//                    child: new Text('Share',style:  TextStyle(fontSize: 20),),
                    child: Icon(Icons.share),
                    onPressed: ()async {
                      await Printing.sharePdf(bytes: doc.save(), filename: '${eventname}_List.pdf');
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
            ),
            _buildEventList(),
          ]
      ),
    );
  }

}


