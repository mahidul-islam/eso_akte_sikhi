import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TwoBorderButton extends StatelessWidget {
  const TwoBorderButton({
    super.key,
    required this.names,
  });
  final String names;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2.6,
      height: Get.width / 8,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.pink,
          width: 4.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 4.5,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            names,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class Tex extends StatelessWidget {
  const Tex({
    super.key,
    required this.rcvd,
    required this.fsize,
    required this.colo,
  });

  final double fsize;
  final String rcvd;
  final Color colo;

  @override
  Widget build(BuildContext context) {
    return Text(
      rcvd,
      style: TextStyle(
        fontFamily: 'Jokerman',
        fontWeight: FontWeight.bold,
        fontSize: fsize,
        color: colo,
        shadows: const [
          Shadow(
            offset: Offset(-1, -1),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(1, -1),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(1, 1),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(-1, 1),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
