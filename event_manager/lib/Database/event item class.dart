

class  MyEventItems {
  int id;
  String EventName='';
  bool EventTicketed=false;
  int day,month,year;
  String Datetimestring='';
  double EventBudget=0;
  DateTime EventDate;
  double TicketPrice=0;

  MyEventItems();

  setdate(int day, int month, int year){
    this.day=day;
    this.month=month;
    this.year=year;
  }
  MyEventItems.map(dynamic obj){
    this.EventName = obj['EventName'];
    this.EventTicketed=(obj['flag'] == 1)? true : false;
    this.id=obj['id'];
    this.day=obj['day'];
    this.month=obj['month'];
    this.year=obj['year'];

    this.EventBudget=obj['EventBudget'];
    this.TicketPrice=obj['TicketPrice'];
  }

  String get eventname =>EventName;
  double get eventbudget=> EventBudget;
  int get ID => id;
  double get ticketprice=>TicketPrice;
  bool get eventticketed=>EventTicketed;
  int get Day=>day;
  int get Month=>month;
  int get Year=>year;
  DateTime get eventdate=>EventDate;


  Map<String,dynamic>toMap(){
    var map= new Map<String,dynamic>();
    map['EventName']=EventName;
    map['EventBudget']=EventBudget;
    map['TicketPrice']=TicketPrice;
    map['day']=day;
    map['month']=month;
    map['year']=year;
    map['flag']=(EventTicketed)? 1 : 0;
    if(id!=null){
      map['id']=id;
    }
    return map;
  }

  MyEventItems.fromMap(Map<String,dynamic> map){
    this.EventBudget=map['EventBudget'];
    this.EventName= map['EventName'];
    this.id=map['id'];
    this.EventTicketed=(map['flag'] == 1)? true : false;
    this.day=map['day'];
    this.month=map['month'];
    this.year=map['year'];
    this.TicketPrice=map['TicketPrice'];
  }

  save() {
    print('saving event');
  }


}

class todo{
  int id;
  String Item='';
  int eventid;
  todo();
//  void set item(String item)
//  {
//    this.Item=item;
//  }
  String get item=>Item;
  int get Eventid=>eventid;
  todo.map(dynamic obj){
    this.id=obj["id"];
    this.Item=obj['todoitem'];
    this.eventid=obj['eventid'];
  }
  Map<String,dynamic>toMap() {
    var map = new Map<String, dynamic>(
    );
    map['eventid']=this.eventid;
    map['todoitem'] = Item;
    return map;
  }
  todo.fromMap(Map<String,dynamic> map){
    this.id = map['id'];
    this.eventid=map['eventid'];
    this.Item = map['todoitem'];
  }

}

class people{
  int id;
  int eventid;
  int plus=0;
  String Name='';
  int ContactNo=0000000000;
  bool Confirmation=false,Paid=false,Received=false;
  double AmountPaid=0;
  people();

  String get name=>Name;
  int get contactno=> ContactNo;
  int get Plus=> plus;
  bool get confirmation=>Confirmation;
  bool get paid=>Paid;
  bool get received=>Received;
  double get amountpaid=>AmountPaid;
  int get Eventid=>eventid;

  people.map(dynamic obj){
    this.id=obj['id'];
    this.plus=obj['plus'];
    this.eventid=obj['eventid'];
    this.Name = obj['Name'];
    this.ContactNo = obj['ContactNo'];
    this.Confirmation=(obj['Confirmationflag'] == 1)? true : false;
    this.Paid=(obj['Paidflag'] == 1)? true : false;
    this.Received=(obj['Receivedflag'] == 1)? true : false;
    this.AmountPaid=obj['AmountPaid'];
  }

  Map<String,dynamic>toMap(){
    var map= new Map<String,dynamic>();
    map['Name']=Name;
    map['plus']=plus;
    map['ContactNo']=ContactNo;
    map['AmountPaid']=AmountPaid;
    map['Confirmationflag']=(Confirmation)? 1 : 0;
    map['Paidflag']=(Paid)? 1 : 0;
    map['Receivedflag']=(Received)? 1 : 0;
    if(id!=null){
      map['id']=id;
    }
    map['eventid']=this.eventid;
    return map;
  }
  people.fromMap(Map<String,dynamic> map){
    this.id=map['id'];
    this.plus=map['plus'];
    this.eventid=map['eventid'];
    this.Name = map['Name'];
    this.ContactNo = map['ContactNo'];
    this.Confirmation=(map['Confirmationflag'] == 1)? true : false;
    this.Paid=(map['Paidflag'] == 1)? true : false;
    this.Received=(map['Receivedflag'] == 1)? true : false;
    this.AmountPaid=map['AmountPaid'];
  }

}

class expenses{
  int id;
  double cost=0;
  String spentOn;
  int eventid;
  expenses();
//  void set item(double cost)
//  {
//    this.cost=cost;
//  }
  double get Cost=>cost;
  int get Eventid=>eventid;
  String get SpentOn=>spentOn;
  expenses.map(dynamic obj){
    this.id=obj["id"];
    this.cost=obj['cost'];
    this.eventid=obj['eventid'];
    this.spentOn=obj['spenton'];
  }
  Map<String,dynamic>toMap() {
    var map = new Map<String, dynamic>(
    );
    map['eventid']=this.eventid;
    map['cost'] = cost;
    map['spenton']=spentOn;
    return map;
  }
  expenses.fromMap(Map<String,dynamic> map){
    this.id = map['id'];
    this.eventid=map['eventid'];
    this.cost = map['cost'];
    this.spentOn=map['spenton'];
  }

}