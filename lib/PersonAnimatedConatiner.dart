import 'package:flutter/material.dart';

class PersonAnimatedContainer extends StatefulWidget {
  String content;
  bool danger;
  bool selected;
  PersonAnimatedContainer({
    this.content,
    this.danger,
    this.selected,
    Key key,
  }) : super(key: key);

  @override
  _PersonAnimatedContainerState createState() =>
      _PersonAnimatedContainerState();
}

class _PersonAnimatedContainerState extends State<PersonAnimatedContainer> {

  double heightFactorSelected = 0.185;
  double heightFactorUnselected = 0.065;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: AnimatedContainer(
        color: widget.selected ? widget.danger ? Colors.red : Colors.blue : Colors.white,
        height: widget.selected
            ? height * heightFactorSelected
            : height * heightFactorUnselected,
        duration: Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.content),
            Container(color: Colors.grey, height: 1),
          ],
        ),
      ),
    );
  }
}
