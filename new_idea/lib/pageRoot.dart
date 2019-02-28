import "package:flutter/material.dart";

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

  @override
  Widget build(BuildContext context) {
    var animation =
        Tween(begin: 0, end: MediaQuery.of(context).size.width / 3).animate(gi);

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
                offset: Offset(animation.value, 100),
              );
            },
          ),
        ],
      ),
    );
  }
}
