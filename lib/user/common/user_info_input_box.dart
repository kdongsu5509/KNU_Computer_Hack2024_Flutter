import 'package:flutter/material.dart';
import 'package:knu_homes/const/MyColor.dart';

/**
 * 사용자가 입력하는 상자
 * 로그인 및 회원가입 페이지에서 사용
 */

class UserInfoInputBox extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;

  const UserInfoInputBox({
    required this.labelText,
    required this.controller,
    this.isPassword = false, // 기본값 false 설정
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfoInputBox> createState() => _UserInfoInputBoxState();
}

class _UserInfoInputBoxState extends State<UserInfoInputBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.1,
        MediaQuery.of(context).size.width * 0.07,
        MediaQuery.of(context).size.width * 0.1,
        MediaQuery.of(context).size.width * 0.0,
      ),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          filled: true,
          // 필드 배경색 활성화
          fillColor: MY_GREY,
          // 회색 설정
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.07),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.07),
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: widget.labelText,
        ),
      ),
    );
  }
}
