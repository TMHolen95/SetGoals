import 'package:flutter/material.dart';

class FadingRadio extends StatefulWidget {
  final int value;
  final int groupValue;
  final bool fade;
  final Function(int) onChanged;

  const FadingRadio(
      {Key key, this.value, this.groupValue, this.fade, this.onChanged})
      : super(key: key);

  @override
  _FadingRadioState createState() => _FadingRadioState();
}

class _FadingRadioState extends State<FadingRadio> {
  bool _visible;

  @override
  void initState() {
    super.initState();
    _visible = true;
  }

  Widget animatedEmptyRadio(){
    return Radio(
        value: widget.value,
        groupValue: null,
        onChanged: (value) {
          setState(() {
            print("Visible set to false");
            _visible = false;
          });
          Future.delayed(Duration(milliseconds: 500)).then((val) =>
              setState(() => _visible = true));
          return widget.onChanged(value);
        });
  }

  Widget selectedRadio(){
    return Radio(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: (value) {
          return widget.onChanged(value);
        });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.fade){
      return AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: animatedEmptyRadio(),
        secondChild: selectedRadio(),
        firstCurve: Curves.linearToEaseOut,
        secondCurve: Curves.easeIn,
        crossFadeState:
        _visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      );
    } else {
      return selectedRadio();
    }
  }
}
