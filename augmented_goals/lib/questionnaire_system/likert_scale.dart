import 'package:flutter/material.dart';
import 'package:augmented_goals/questionnaire_system/fading_radio.dart';
import 'package:augmented_goals/questionnaire_system/label.dart';

/// A [LikertScale] is created with x [radioButtons].
///
/// The texts specified in the [labels] are spaced evenly beneath the radio buttons.
///
class LikertScale extends StatefulWidget {
  @required
  final int radioButtons;
  final int preSelectedValue;
  final bool autoProgress;
  final bool animate;
  final bool showNumbers;
  final List<String> labels;
  final Function(int) onChange;

  const LikertScale({Key key,
    this.radioButtons,
    this.labels,
    this.onChange,
    this.preSelectedValue,
    this.autoProgress, this.showNumbers = true, this.animate = true})
      : super(key: key);

  @override
  _LikertScaleState createState() => _LikertScaleState();
}

class _LikertScaleState extends State<LikertScale> {
  int selection;

  @override
  void initState() {
    super.initState();
    //print("Likert scale received: ${widget.labels}");
    selection = widget.preSelectedValue;
  }

  ///  Convenience function that delivers [Label]s
  ///
  ///  Note, should be run in a loop.
  ///  1: either at every [Radio], [widget.labels] is equal to [widget.radioButtons].
  ///  2: The first and last Radio, [widget.labels] is equal to 2.
  ///  3: The first, middle and last Radio. [widget.labels] is equal to 3.
  Label radioLabel(int index) {
    int labels = widget.labels.length;
    int buttons = widget.radioButtons;

    // Case the number of labels contains enough labels for the start, and end.
    if (labels == 2) {
      if (index == 0) {
        return Label(widget.labels[0]);
      } else if (index == buttons - 1) {
        return Label(widget.labels[1]);
      } else {
        return Label(" "); // Empty label to simplify styling;
      }
    }
    // Case the number of labels contains enough labels for the start, middle and end.
    else if (labels == 3) {
      if (index == 0) {
        // start
        return Label(widget.labels[0]);
      } else if (index == buttons - 1) {
        // endpoint
        return Label(widget.labels[2]);
      } else if (index == ((buttons - 1) / 2)) {
        // midpoint
        return Label(widget.labels[1]);
      } else {
        return Label(" "); // Empty label to simplify styling;
      }
    }
    // Case the number of labels provided is equal to the number of [Radio]'s
    else if (labels == buttons) {
      return Label(widget.labels[index]);
    }

    return Label("Weird");
  }

  List<Widget> labeledRadios(){
    List<Widget> labeledRadio = <Widget>[];
    for (int i = 0; i < widget.radioButtons; i++) {
      labeledRadio.add(Column(
        children: <Widget>[
          (widget.showNumbers) ? Label((i + 1).toString()) : Container(),
          Visibility(
            visible: !widget.animate,
            child: Radio(
                value: i,
                groupValue: (widget.autoProgress) ? selection : widget.preSelectedValue,
                onChanged: (value) =>
                    setState(() {
                      widget.onChange(value);
                      return selection = value;
                    })),
          ),
          Visibility(
            visible: widget.animate,
            child: FadingRadio(
                value: i,
                groupValue: (widget.autoProgress) ? selection : widget.preSelectedValue,
                fade: widget.autoProgress,
                onChanged: (value) =>
                    setState(() {
                      widget.onChange(value);
                      return selection = value;
                    })),
          ),

          radioLabel(i),
        ],
      ));
    }
    return labeledRadio;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: labeledRadios());
  }
}
