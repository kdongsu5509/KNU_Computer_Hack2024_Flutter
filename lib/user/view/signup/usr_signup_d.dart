import 'package:flutter/material.dart';
import 'package:knu_homes/project_common/default_frame.dart';
import '../../../project_common/page_title_box.dart';
import '../../common/user_info_input_box.dart';
import '../../common/user_login_register_button.dart';

class UsrSignupD extends StatefulWidget {
  const UsrSignupD({super.key});

  @override
  State<UsrSignupD> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<UsrSignupD> {

  @override
  Widget build(BuildContext context) {
    return DefaultFrame(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.005),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageTitleBox(pageTitle: '홈즈에 오신 걸 환영해요!', verticalPadding: 0.2),
                Image.asset(
                  'asset/img/knu_homes_logo_full.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                // 드롭다운 추가
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                UserInfoInputBox(labelText: '  비밀번호', isPassword: true),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                UserInfoInputBox(labelText: '  비밀번호를 한번 더 입력하세요', isPassword: true),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                UserLoginRegisterButton(
                  buttonText: '회원가입',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
