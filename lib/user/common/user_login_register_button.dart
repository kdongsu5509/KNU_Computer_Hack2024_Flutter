import 'package:flutter/material.dart';
import 'package:knu_homes/const/MyColor.dart';

/**
 * 사용자가 로그인 및 회원가입 시 '다음'을 누르면 사용되는 버튼
 * 로그인 및 회원가입 페이지에서 사용
 */
class UserLoginRegisterButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final bool isSecession;

  const UserLoginRegisterButton({
    required this.buttonText,
    required this.onPressed,
    this.isSecession = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.8,
          MediaQuery.of(context).size.height * 0.05,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.07),
        ),
        backgroundColor: (isSecession) ? MY_ORANGE :MY_BLUE,
        foregroundColor: Colors.black,
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
      ),
    );
  }
}
