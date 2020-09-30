import 'package:flutter/material.dart';
import 'package:foodie_deliveryman/model/order.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new ListPage(title: 'Orders to pickup'),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.assignment, "To Pick Up", Colors.red,
        labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    new TabItem(Icons.assignment_returned, "To Deliver", Colors.orange,
        labelStyle:
        TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
    new TabItem(Icons.assignment_turned_in, "Done", Colors.green,
        labelStyle:
        TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
  ]);

  int selectedPos = 0;
  double bottomNavBarHeight = 60;

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Order order) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        order.orderName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),

      subtitle: Row(
        children: (selectedPos == 0) ?
        <Widget>[Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("Pickup Location: ${order.pickupLocation}",
                  style: TextStyle(color: Colors.white))),
        )] : (selectedPos == 1) ?
        <Widget>[Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text("Delivery Location: ${order.deliveryLocation}",
                  style: TextStyle(color: Colors.white))),
        )] : <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Pickup Location: ${order.pickupLocation}",
                    style: TextStyle(color: Colors.white))),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 40.0),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Delivery Location: ${order.deliveryLocation}",
                    style: TextStyle(color: Colors.white))),
          )
        ],
      ),
      trailing: (selectedPos != 2) ?
      IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.green,
            size: 30.0,
          ),
          onPressed: () {
            print('order change delivery state');
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => DetailPage(order: order)));
          }) :
      null,
      // onTap: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => DetailPage(order: order)));
      // },
    );

    Card makeCard(Order order) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(order),
      ),
    );

    Widget ordersBody() {
      List ordersInCurrentState;
      switch (selectedPos) {
        case 0:
          ordersInCurrentState = getOrdersToPickUp();
          break;
        case 1:
          ordersInCurrentState = getOrdersToDeliver();
          break;
        case 2:
          ordersInCurrentState = getOrdersDone();
          break;
      }
      return Container(
        // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ordersInCurrentState.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(ordersInCurrentState[index]);
          },
        ),
      );
    }

    Widget topBar() {
      String title;
      switch (selectedPos) {
        case 0:
          title = "To Pick Up";
          break;
        case 1:
          title = "To Deliver";
          break;
        case 2:
          title = "Done";
          break;
      }

      return AppBar(
          elevation: 1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            title,
            style: TextStyle(color: Colors.blue),
          ));
    }

    Widget bottomNav() {
      return CircularBottomNavigation(
        tabItems,
        controller: _navigationController,
        barHeight: bottomNavBarHeight,
        barBackgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        selectedCallback: (int selectedPos) {
          setState(() {
            this.selectedPos = selectedPos;
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topBar(),
      body: ordersBody(),
      bottomNavigationBar: bottomNav(),
    );
  }
}

List getOrders() {
  return [
    Order(
        orderName: "Introduction to Driving",
        pickupLocation: "Beginner",
        deliveryLocation: "0.33",
        price: 20,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Observation at Junctions",
        pickupLocation: "Beginner",
        deliveryLocation: "0.33",
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Reverse parallel Parking",
        pickupLocation: "Intermidiate",
        deliveryLocation: "0.66",
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Reversing around the corner",
        pickupLocation: "Intermidiate",
        deliveryLocation: "0.66",
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Incorrect Use of Signal",
        pickupLocation: "Advanced",
        deliveryLocation: "1.0",
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Engine Challenges",
        pickupLocation: "Advanced",
        deliveryLocation: "1.0",
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Self Driving Car",
        pickupLocation: "Advanced",
        deliveryLocation: "1.0",
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}

List getOrdersToPickUp() {
  return [
    Order(
        orderName: "Introduction to Driving",
        pickupLocation: "Beginner",
        deliveryLocation: "0.33",
        price: 20,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Observation at Junctions",
        pickupLocation: "Beginner",
        deliveryLocation: "0.33",
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Reverse parallel Parking",
        pickupLocation: "Intermidiate",
        deliveryLocation: "0.66",
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.")
  ];
}

List getOrdersToDeliver() {
  return [
    Order(
        orderName: "Reversing around the corner",
        pickupLocation: "Intermidiate",
        deliveryLocation: "0.66",
        price: 30,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Order(
        orderName: "Incorrect Use of Signal",
        pickupLocation: "Advanced",
        deliveryLocation: "1.0",
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.")
  ];
}

List getOrdersDone() {
  return [
    Order(
        orderName: "Self Driving Car",
        pickupLocation: "Advanced",
        deliveryLocation: "1.0",
        price: 50,
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}
