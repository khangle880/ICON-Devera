import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ExpandedSnackBar on SnackBar {
  static ScaffoldMessengerState showStatusSnackBar(
      BuildContext context, List<Widget> children,
      {Duration? duration}) {
    return ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).primaryColorDark,
          duration: duration ?? Duration(milliseconds: 4000),
        ),
      );
  }

  static ScaffoldMessengerState showLoadingSnackBar(
      BuildContext context, String textMessage) {
    return showStatusSnackBar(
      context,
      <Widget>[
        Flexible(
          child: Text(
            textMessage,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 20.h,
          width: 20.h,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
      ],
      duration: Duration(hours: 1),
    );
  }

  static ScaffoldMessengerState showSuccessSnackBar(
      BuildContext context, String textMessage) {
    return showStatusSnackBar(
      context,
      <Widget>[
        Flexible(
          child: Text(
            textMessage,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
        ),
        Icon(
          Icons.check,
          color: Colors.white,
        ),
      ],
      duration: Duration(milliseconds: 1000),
    );
  }

  static ScaffoldMessengerState showFailureSnackBar(
      BuildContext context, String textMessage) {
    return showStatusSnackBar(context, <Widget>[
      Flexible(
        child: Text(
          textMessage,
          overflow: TextOverflow.ellipsis,
          style:
              Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
        ),
      ),
      Icon(
        Icons.error_outline_sharp,
        color: Colors.white,
      ),
    ]);
  }
}
