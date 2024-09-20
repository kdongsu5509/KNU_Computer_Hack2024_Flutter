import 'package:flutter/material.dart';
import 'package:knu_homes/project_common/reactSize.dart';

Widget CustomDivider({
  required BuildContext context,
  required double indent,
  double thickness = 0.0035, // 기본값 설정
}) {
  return Divider(
    color: Colors.black,
    thickness: myFHeight(context, thickness), // myFHeight로 높이 계산
    indent: myFWidth(context, indent),
    endIndent: myFWidth(context, indent),
  );
}
