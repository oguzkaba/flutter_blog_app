import 'package:flutter/material.dart';
import 'package:flutter_blog_app/app/global/utils/constants.dart';

class NavBadgeIcon extends StatelessWidget {
  final IconData iconData;
  final int? notificationCount;

  const NavBadgeIcon({
    Key? key,
    required this.iconData,
    this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(iconData),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: myRedColor),
                alignment: Alignment.center,
                child: Text('$notificationCount',
                    style: TextStyle(color: myWhiteColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
