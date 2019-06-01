import 'package:augmented_goals/widgets/list_tiles/text_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class ListHelper{
  static Widget prePopulatedListCases(AsyncSnapshot<QuerySnapshot> snapshot, String message){
    if (!snapshot.hasData)
      return Center(child: CircularProgressIndicator());
    if (snapshot.data.documents.isEmpty) {
      return TextTile(
        message: message,
      );
    }else{
      return null;
    }
  }
}