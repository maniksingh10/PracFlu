import "package:flutter/material.dart";
import 'dart:math' as math;

main(List<String> args) {
  runApp(PracticeApp());
}

class PracticeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Practice",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: StateFullClass(),
    );
  }
}

class StateFullClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _sStateFullClass();
  }
}

class _sStateFullClass extends State<StateFullClass>
    with TickerProviderStateMixin {
  AnimationController _controller;

  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  static const List<IconData> icons = const [
    Icons.sms,
    Icons.mail,
    Icons.phone
  ];

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  final snakcbar = SnackBar(
    content: Text('Working'),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Practice")), actions: <Widget>[
        BackButton(),
      ]),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          )
        ],
      ),
      floatingActionButton: floatanim(),
    );
  }

  Widget floatButton() {
    return Container(
        child: FloatingActionButton(
      onPressed: () {
        setState(() {
          Scaffold.of(context).showSnackBar(snakcbar);
        });
      },
      child: Icon(Icons.add),
    ));
  }

  Widget floatanim() {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: new List.generate(icons.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: new ScaleTransition(
            scale: new CurvedAnimation(
              parent: _controller,
              curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: new FloatingActionButton(
              heroTag: null,
              backgroundColor: backgroundColor,
              mini: true,
              child: new Icon(icons[index], color: foregroundColor),
              onPressed: () {},
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform:
                      new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(
                      _controller.isDismissed ? Icons.share : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: color,
      ),
    );
  }
}
