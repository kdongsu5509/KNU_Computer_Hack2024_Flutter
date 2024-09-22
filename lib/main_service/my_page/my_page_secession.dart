import 'package:flutter/material.dart';
import 'package:knu_homes/main_service/my_page/my_page_edit_and_secession.dart';

import '../../project_common/customDivider.dart';
import '../../project_common/page_title_box.dart';
import '../../user/common/user_info_input_box.dart';
import '../../user/common/user_login_register_button.dart';

class MyPageSecession extends StatelessWidget {
  const MyPageSecession({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CustomDivider(context: context, indent: 0.04),
            PageTitleBox(pageTitle: '이용해주셔서 감사합니다.\n근데진짜나가시나요?ㅠㅠ\n한번만더생각해보시면안될까요ㅠㅠ', verticalPadding: 0.2, editTitle: true),
            Image.asset(
              'asset/img/knu_homes_logo_basic.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            UserInfoInputBox(labelText: '비밀번호', controller: passwordController, isPassword: true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            UserLoginRegisterButton(
              buttonText: '탈퇴하기',
              onPressed: () {

              },
              isSecession: true,
            ),
          ],
        ),
      ),
    );
  }
}
