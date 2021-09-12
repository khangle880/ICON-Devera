import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/utils/extensions/extensions.dart';
import 'package:icon/widgets/keyboard_number.dart';

class PinPanel extends StatefulWidget {
  const PinPanel({
    Key? key,
    required this.onFull,
    required this.enable,
    required this.inititalValue,
  }) : super(key: key);
  final Function(String) onFull;
  final bool enable;
  final String inititalValue;

  @override
  _PinPanelState createState() => _PinPanelState();
}

class _PinPanelState extends State<PinPanel> {
  late String pin;
  @override
  void initState() {
    pin = widget.inititalValue;
    super.initState();
  }

  final List<String> numKey = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 113.w),
          child: PinRow(pin: pin),
        ),
        SizedBox(height: 140.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Wrap(
            runSpacing: 8.h,
            spacing: 24.w,
            children: [
              ...numKey
                  .map((e) => KeyBoardInput(
                      number: e,
                      onPressed: () {
                        if (pin.length < 4 && widget.enable) {
                          final newPin = pin + e;
                          setState(() {
                            pin = newPin;
                          });
                          if (newPin.length == 4) {
                            widget.onFull(newPin);
                            Future.delayed(
                              Duration(milliseconds: 300),
                              () => setState(() {
                                pin = "";
                              }),
                            );
                          }
                        }
                      }))
                  .toList(),
              InkWell(
                borderRadius: BorderRadius.circular(100.r),
                splashColor: Colors.white,
                highlightColor: Colors.white,
                onTap: () {
                  if (pin.isNotEmpty && widget.enable) {
                    setState(() {
                      pin = pin.substring(0, pin.length - 1);
                    });
                  }
                },
                child: Container(
                  width: 81.h,
                  height: 81.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      ),
                  child: Icon(
                    Icons.backspace_outlined,
                    color: ExpandedColor.fromHex("#003282"),
                    size: 30.w,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PinRow extends StatelessWidget {
  const PinRow({
    Key? key,
    required this.pin,
  }) : super(key: key);

  final String pin;

  @override
  Widget build(BuildContext context) {
    // if (pin.length > 4) pin = pin.substring(0, 4);
    return Wrap(
      spacing: 20.w,
      children: [
        ...List<Widget>.generate(
          4,
          (index) => AnimatedContainer(
            width: 22.h,
            height: 22.h,
            decoration: BoxDecoration(
              color: index + 1 <= pin.length
                  ? Color(0xFF75BF72)
                  : Color(0xFF9EA5B1),
              borderRadius: BorderRadius.circular(30.r),
            ),
            duration: Duration(milliseconds: 50),
          ),
        ),
      ],
    );
  }
}
