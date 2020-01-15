import 'package:event_manager/Events/EventsListPage.dart';
import 'package:event_manager/Print/Printable_Eventbased.dart';
import 'package:event_manager/Todo/todolist%20page.dart';
import 'package:flutter/material.dart';



class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MainActivity extends StatefulWidget {
  final drawerItems = [
//    new DrawerItem("Home", Icons.home),
//    new DrawerItem("Sign out", Icons.person),
    new DrawerItem("My Events", Icons.calendar_today),
    new DrawerItem("Print people list", Icons.print),
    new DrawerItem("Todo List", Icons.check),
    new DrawerItem("Send Invites", Icons.textsms)
  ];

  @override
  State<StatefulWidget> createState() {
    return new MainActivitystate();
  }
}

class MainActivitystate extends State<MainActivity> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new EventList();
      case 1:
        return new EventList_forpeople();
      case 2:
        return new ToDoList(event: null,);
      case 3:
        return Null;

      default:
        return new Text("Error");
    }
  }


  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  
  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon,),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title,),
//        backgroundColor: Theme.of(context).primaryColorLight,

      ),
      drawer: new Drawer(

        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
//              accountName: new Text("John Doe"),
              accountEmail: new Text(""),
              accountName: Text("Guest User"),
              currentAccountPicture: Icon(Icons.person,size: 80,color: Colors.white54,),
            ),

            new Column(children: drawerOptions)
          ],
        ),
      ),
      body:
          _getDrawerItemWidget(_selectedDrawerIndex),

    );
  }
}