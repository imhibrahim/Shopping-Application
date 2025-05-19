import 'package:flutter/material.dart';
import 'package:shoopingapp/utlis/app_constain.dart';

class headingwidget extends StatelessWidget {
  final String HeadingTitle;
  final String HeadingSubTitle;
  final VoidCallback onTap;
  final String buttonText;

  headingwidget({
    super.key,
    required this.HeadingTitle,
    required this.HeadingSubTitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(8),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  HeadingTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  HeadingSubTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.5,
                    color: AppConstent.appSecondaryColor,
                  ),
                 ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppConstent.appSecondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
