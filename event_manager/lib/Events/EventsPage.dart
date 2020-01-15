import 'package:event_manager/expenses/Expenses_list.dart';
import 'package:event_manager/people/InvitedPeopleListPage.dart';
import 'package:flutter/material.dart';
import 'package:event_manager/Todo/todolist page.dart';
import 'package:event_manager/Database/event item class.dart';

class TabbedAppBarSample extends StatelessWidget {

  final MyEventItems event;
  TabbedAppBarSample({Key key, @required this.event}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("entered tab view");
    return  DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(event.EventName.toString()),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: tabpageview(choice),
              );
            }).toList(),
          ),
        ),
      );

  }

  Widget tabpageview(Choice choice){
//      final TextStyle textStyle = Theme.of(context).textTheme.display1;
      switch (choice.id) {
        case 1:
          return  Card(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Text(""),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cake),
                        Text("Event: ${event.eventname}",style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        Text("Budget: ${event.eventbudget}",style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Text("Date: ${event.day}-${event.month}-${event.year}",style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        event.ticketprice>0?Icon(Icons.event_seat):Text(""),
                        Text(event.ticketprice>0?"Price of each ticket: ${event.ticketprice}":"",style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                  Expanded(child: Text("")),
//                  Image.asset("images/event_background.jpg"),
//
                ],
              ),
            ),
          );
        case 2:
          return PeopleList(event: event);
        case 3:
          return ToDoList(event: event,);
        case 4:
          return ExpenseList(event: event);

        default:
          return new Text("Error");
      }
  }

}



class Choice {
  const Choice({this.id,this.title, this.icon});
  final int id;
  final String title;
  final IconData icon;
}

//const List<Choice> choices = const <Choice>[
//  const Choice(title: 'CAR', icon: Icons.directions_car),
//  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
//  const Choice(title: 'BOAT', icon: Icons.directions_boat),
//  const Choice(title: 'BUS', icon: Icons.directions_bus),
//  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
//  const Choice(title: 'WALK', icon: Icons.directions_walk),
//];

const List<Choice> choices = const <Choice>[
  const Choice(id: 1,title: 'Details', icon: Icons.date_range),
  const Choice(id: 2,title: 'Invited People', icon: Icons.people),
  const Choice(id: 3,title: 'Todo', icon: Icons.list),
  const Choice(id: 4,title: 'Expense', icon: Icons.account_balance_wallet),
];

//class ChoiceCard extends StatelessWidget {
//  const ChoiceCard({Key key, this.choice}) : super(key: key);
//
//  final Choice choice;
//
//  @override
//  Widget build(BuildContext context) {
//    final TextStyle textStyle = Theme.of(context).textTheme.display1;
//    return Card(
//      color: Colors.white,
//      child: Center(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Icon(choice.icon, size: 128.0, color: textStyle.color),
//            Text(choice.title, style: textStyle),
//          ],
//        ),
//      ),
//    );
//  }
//}

//void main() {
//  runApp(TabbedAppBarSample());
//}