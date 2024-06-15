import 'package:eso_akte_sikhi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('HomeView'),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'Assets/mainback.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Tex(
                      rcvd: 'D',
                      fsize: 50,
                      colo: Color.fromARGB(255, 217, 2, 255),
                    ),
                    const Tex(
                      rcvd: 'RAW',
                      fsize: 40,
                      colo: Colors.orange,
                    ),
                    Transform.translate(
                      offset: const Offset(2, 7),
                      child: Transform.rotate(
                        angle: 10 * 3.1415927 / 180,
                        child: Image.asset(
                          'Assets/pencil.png',
                          height: Get.height / 18,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const Tex(
                      rcvd: 'NG',
                      fsize: 40,
                      colo: Colors.orange,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: Get.width / 4),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Tex(
                        rcvd: 'B',
                        fsize: 50,
                        colo: Color.fromARGB(255, 217, 2, 255),
                      ),
                      Tex(
                        rcvd: 'OOK',
                        fsize: 40,
                        colo: Colors.orange,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.EDITOR_PAGE);
                  },
                  child: Image.asset(
                    'Assets/maincenup.png',
                    height: Get.height / 7,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Image.asset(
                  'Assets/maincenter.png',
                  height: Get.height / 3,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: Get.height / 30,
                ),
                Padding(
                  padding: EdgeInsets.all(Get.width / 12),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TwoBorderButton(
                        names: 'RATE APPS',
                      ),
                      TwoBorderButton(
                        names: 'MY DRAWING',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
        fontWeight: FontWeight.bold,
        fontSize: fsize,
        fontStyle: FontStyle.italic,
        color: colo,
        shadows: const [
          Shadow(
            offset: Offset(-2, -2),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(2, -2),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(2, 2),
            color: Colors.black,
          ),
          Shadow(
            offset: Offset(-2, 2),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
