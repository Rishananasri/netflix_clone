import 'package:flutter/material.dart';

class TopFilterButtons extends StatelessWidget {
  const TopFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 17),
        _filterButton("Shows", 70),
        SizedBox(width: 10),
        _filterButton("Movies", 75),
        SizedBox(width: 10),
        _categoryButton("Categories", 125),
      ],
    );
  }

  Widget _filterButton(String text, double width) {
    return Container(
      height: 34,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color.fromARGB(255, 205, 203, 203)),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 205, 203, 203),
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _categoryButton(String text, double width) {
    return Container(
      height: 34,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color.fromARGB(255, 205, 203, 203)),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$text ",
              style: TextStyle(
                color: Color.fromARGB(255, 205, 203, 203),
                fontSize: 15,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Color.fromARGB(255, 205, 203, 203),
            ),
          ],
        ),
      ),
    );
  }
}
