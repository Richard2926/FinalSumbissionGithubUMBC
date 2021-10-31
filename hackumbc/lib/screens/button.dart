

import 'package:flutter/material.dart';
import 'package:hackumbc/components/constants.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          this.setState(() {
            added = !added;
          });
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: added ? Colors.pinkAccent :Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            added ? "Added To Budget !" : "Add To Budget",
            style: kTitleStyle.copyWith(
              color: added ? Colors.white :Colors.white,),
          ),
        ),
      ),
    );
  }
}