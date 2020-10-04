import 'dart:async';
import 'package:flutter/material.dart';

class BlinkWidget extends StatefulWidget {
  final List<Widget> children;
  final int interval;
  final int damagingCount;
  BlinkWidget(
      {@required this.children,
      this.interval = 50,
      Key key,
      this.damagingCount})
      : super(key: key);
  @override
  _BlinkWidgetState createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _currentWidget = 0;
  bool blinking = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
        duration: Duration(milliseconds: widget.interval), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (++_currentWidget == widget.children.length) {
            _currentWidget = 0;
          }
        });
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  void didUpdateWidget(BlinkWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.damagingCount > 0) {
      _controller.forward();
      new Timer(const Duration(milliseconds: 100), () {
        _controller.stop();
        setState(() {
          _currentWidget = 0;
          blinking = true;
        });
      });
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.children[_currentWidget],
    );
  }
}
