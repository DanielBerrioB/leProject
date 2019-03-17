import "package:flutter/material.dart";
import "service.dart";

class PageRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageRoot();
}

class _PageRoot extends State<PageRoot> with TickerProviderStateMixin {
  AnimationController gi;
  List itemsList = new List();
  var pressed = false;

  @override
  initState() {
    super.initState();
    gi = AnimationController(duration: Duration(seconds: 5), vsync: this)
      ..repeat();
  }

  //This function creates the list when the button has been pressed
  ListView getList(){
    return ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) {
        final String item = itemsList[index];
        return Dismissible(
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            setState(() {
              this.itemsList.removeAt(index);
            });
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(dir == DismissDirection.startToEnd
                    ? "$item removido"
                    : "$item agregado"),
                action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      setState(() {
                        this.itemsList.insert(index, item);
                      });
                    }),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: Container(
            color: Colors.green,
            child: Icon(Icons.thumb_up),
            alignment: Alignment.centerRight,
          ),
          child: ListTile(
            title: Text("${itemsList[index]}"),
          ),
        );
      },
    );
  }

  toMap(value) {
    Map<String, dynamic> userMap = value;
    var user = Information.fromJson(userMap);
    itemsList.add(user.title);
  }

  RaisedButton button() {
    var nuevo = new HttpResponse();
    var data = nuevo.getData();
    return new RaisedButton(
        onPressed: () {
          data.then((value) {
            value.forEach((i) => toMap(i));
          });
          setState(() {
            this.pressed = true;
          });
        },
        child: new Text("TAP ME"));
  }

  @override
  Widget build(BuildContext context) {
    var animation =
        Tween(begin: 0.0, end: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 3)
            .animate(gi); //Limits of the animation from 0 to 1/3 of the screen's device

    return new Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text("Hi this is just a proof"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 60.0,
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            child: AnimatedBuilder(
              animation: animation,
              child: Text(
                "List",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              builder: (context, child) {
                return Transform.translate(
                  child: child,
                  offset: Offset(animation.value, 20.0),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 80.0
            ),
            child: Container(
              height: 60.0,
              child: Center(
                child: button(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 130.0,
              left: 40.0,
              right: 40.0
            ),
            child: !pressed ? Text("No hay nada que mostrar") : getList(),
          ),
        ],
      ),
    );
  }
}

/*
 * This class represents the basic model from the JSON file
 */
class Information {
  int userId;
  int id;
  String title;

  Information(this.userId, this.id, this.title);

  Information.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        title = json["title"];

  Map<String, dynamic> toJson() => {"userId": userId, "id": id, "title": title};
}