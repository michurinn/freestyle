
import 'package:flutter/material.dart';

class MyInheritedWidget extends StatefulWidget {
  MyInheritedWidget({super.key, required this.child});
  final Widget child;

  @override
  State<MyInheritedWidget> createState() => _MyInheritedWidgetState();

  static _MyInheritedWidgetState of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<_myInheritedWidget>()!
        .data);
  }
}

class _MyInheritedWidgetState extends State<MyInheritedWidget> {
  List _items = [];
  int get itemsCount => _items.length;
  void addItem(String reference) {
    setState(() {
      _items.add(new Item(reference));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _myInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    final _MyInheritedWidgetState state = MyInheritedWidget.of(context);
    List<Widget> tmpLst = [];
    for (int i = 0; i < state.itemsCount; i++) {
      tmpLst.add(Container(
        color: Color.fromARGB(i*100, i*50, i*10, i*25),
        child: Center(child: Text("{$i is here..}")),
      ));
    }
    return   GridView.count(crossAxisCount: 3, children: tmpLst,);
  }
}

class butt extends StatelessWidget {
  const butt({super.key});

  @override
  Widget build(BuildContext context) {
    final _MyInheritedWidgetState state = MyInheritedWidget.of(context);
    return TextButton(
      child: const Text('Add Item'),
      onPressed: () {
        state.addItem(DateTime.now().toString());
      },
    );
  }
}

class _myInheritedWidget extends InheritedWidget {
  const _myInheritedWidget({required super.child, required this.data});

  final _MyInheritedWidgetState data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class Item {
  String reference;
  Item(this.reference);
}
