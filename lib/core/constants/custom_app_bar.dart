  import 'package:flutter/material.dart';

PreferredSize customAppBar(
      {required String label, required bool showLeading}) {
    return PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: AppBar(
            title: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 25),
            ),
            automaticallyImplyLeading: showLeading,
          ),
        ));
  }
