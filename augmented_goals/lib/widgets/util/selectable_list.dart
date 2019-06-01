import 'package:augmented_goals/widgets/list_tiles/selectable_text_tile.dart';
import 'package:flutter/material.dart';

class SelectableList extends StatefulWidget {
  final List<String> reportCategories;
  final Function(String) onSelection;

  const SelectableList({Key key, this.reportCategories, this.onSelection})
      : super(key: key);

  @override
  SelectableListState createState() => SelectableListState();
}

class SelectableListState extends State<SelectableList> {
  int selection;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scrollbar(
            child: ListView.builder(
              itemCount: widget.reportCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return SelectableTextTile(
                  message: widget.reportCategories[index],
                  onTap: () {
                    setState(() {
                      selection == index
                        ? selection = null
                        : selection = index;
                    });
                    widget.onSelection(widget.reportCategories[index]);
                  },
                  selected: index == selection ?? false,
                );
              },
            ),
          )),
    );
  }
}