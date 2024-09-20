import 'package:flutter/material.dart';

/**
 * @param context: BuildContext
 * @param size: double
 * @return double
 *
 * 너비와 높이를 비율로 설정할 때 사용
 */

double myFHeight(BuildContext context, double size) {
  return MediaQuery.of(context).size.height * size;
}

double myFWidth(BuildContext context, double size) {
  return MediaQuery.of(context).size.width * size;
}