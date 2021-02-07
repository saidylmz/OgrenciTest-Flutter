import 'dart:async';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otsappmobile/models/test_detail_screen_model.dart';
import 'package:otsappmobile/screens/test_detail/test_detail_screen.dart';
import '../../../constants.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key key,
    @required this.minute,
    this.timeout, this.testId,
  }) : super(key: key);

  final VoidCallback timeout;
  final int minute;
  final int testId;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(50)),
      child: Stack(
        children: [
          // LayoutBuilder provide us the available space for the conatiner
          // constraints.maxWidth needed for our animation
          LayoutBuilder(
            builder: (context, constraints) => Container(
              // from 0 to 1 it takes 60s
              width: constraints.maxWidth * (_start / widget.minute),
              decoration: BoxDecoration(
                  gradient: kPrimaryGradient,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/icons/clock.svg"),
                  Text(
                    "${_start.toString()} / ${widget.minute.toString()}",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text("")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Timer _timer;
  int _start = 1;
  void startTimer() {
    const oneMin = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneMin,
      (Timer timer) {
        if (widget.minute == _start) {
          setState(() {
            timer.cancel();
          });
          widget.timeout();
          errorDialog(
            context,
            "Cevaplarınız kaydedilmiştir.",
            title: "Süre Bitti!",
            positiveText: "Tamam",
            closeOnBackPress: false,
            showNeutralButton: false,
            positiveAction: (){
              Navigator.popAndPushNamed(context, TestDetailScreen.routeName, arguments: TestDetailScreenModel(widget.testId));
            }
          );
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }
}
