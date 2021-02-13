import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'top_statistics.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopStatistics(),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Transform(
                  transform: Matrix4.translationValues(0, 0.0, 0.0),
                  child: SizedBox(
                    width: getProportionateScreenWidth(120),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 8, right: 8, bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.6),
                                    offset: const Offset(1.1, 4.0),
                                    blurRadius: 8.0),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  kPrimaryColor,
                                  kPrimaryLightColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(54.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 54, left: 10, right: 10, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Matematik",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      letterSpacing: 0.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width:
                                                getProportionateScreenWidth(75),
                                            child: Text(
                                              "Anlatım Bozukluğu",
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                letterSpacing: 0.2,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "20 Soru",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      letterSpacing: 0.2,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.lock_clock,
                                        size: 20,
                                        color: Colors.black38,
                                      ),
                                      Text(
                                        "08.02.2021",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 84,
                            height: 84,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 20,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: SvgPicture.asset(
                              "assets/icons/Star Icon.svg",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.fromLTRB(
                  getProportionateScreenWidth(25),
                  getProportionateScreenHeight(25),
                  getProportionateScreenWidth(20),
                  0),
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(5)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(68.0),
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topRight: Radius.circular(68.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                children: [
                  BlinkText(
                    '1 Yeni Mesajınız Var!',
                    style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
                    endColor: kSecondaryColor,
                  ),
                  SizedBox(height:5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Öğretmen: Sercan Çalış",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Sınıf: 11/B",
                        style: TextStyle(fontSize: 14),
                      ),
                      
                    ],
                  ),
                  SizedBox(height:5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Son Giriş: 07.02.2021",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "Toplam Resim: 10",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
