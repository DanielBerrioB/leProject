import "package:flutter/material.dart";
import "service.dart";
import "dart:convert";

class PageRoot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageRoot();
}

class _PageRoot extends State<PageRoot> with TickerProviderStateMixin {
  AnimationController gi;

  @override
  initState() {
    super.initState();
    gi = AnimationController(duration: Duration(seconds: 5), vsync: this)
      ..repeat();
  }

  toMap(value) {
    Map<String, dynamic> userMap = value;
    var user = Information.fromJson(userMap);
    print("Hola Dios, ${user.title}");
  }

  RaisedButton button() {
    var nuevo = new HttpResponse();
    var data = nuevo.getData();
    return new RaisedButton(
        onPressed: () {
          data.then((value) {
            value.forEach((i) => toMap(i));
          });
        },
        child: new Text("TAP ME"));
  }

  @override
  Widget build(BuildContext context) {
    var animation =
        Tween(begin: 0.0, end: MediaQuery.of(context).size.width / 3)
            .animate(gi);

    return new Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text("Hi this is just a proof"),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: animation,
            child: Text(
              "I'm changing",
              style: TextStyle(
                fontSize: 30.0,
              ),
              textAlign: TextAlign.center,
            ),
            builder: (context, child) {
              return Transform.translate(
                child: child,
                offset: Offset(animation.value, 100.0),
              );
            },
          ),
          button(),
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
