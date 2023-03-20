import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Course extends StatelessWidget {
  final String name;
  final String image;
  Course({required this.name, required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 60,
            child: Image.asset(
             image,
              fit: BoxFit.cover,
            ),
            
          ),
          Text(name)
        ],
      ),
    );
  }
}
