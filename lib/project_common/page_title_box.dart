import 'package:flutter/material.dart';

/**
 * 페이지의 제목 표시
 * 로그인 및 회원가입 페이지에서 사용
 */

class PageTitleBox extends StatelessWidget {
  final String pageTitle;
  final double verticalPadding;
  final bool editTitle;

  const PageTitleBox({
    required this.pageTitle,
    this.verticalPadding = 0.25,
    this.editTitle = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * verticalPadding),
      child: Text(
        pageTitle,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.06,
          fontWeight: FontWeight.bold,
        ),
        textAlign: (editTitle) ? TextAlign.center : null,
      ),
    );
  }
}
