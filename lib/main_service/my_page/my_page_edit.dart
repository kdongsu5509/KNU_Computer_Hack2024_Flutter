import 'package:flutter/material.dart';
import 'package:knu_homes/main_service/my_page/my_page_edit_and_secession.dart';

import '../../project_common/customDivider.dart';
import '../../user/common/page_title_box.dart';
import '../../user/common/user_input_box.dart';
import '../../user/common/user_login_register_button.dart';

class MyPageEdit extends StatelessWidget {
  const MyPageEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit/Secession',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CustomDivider(context: context, indent: 0.04),
            PageTitleBox(pageTitle: '수정을 위해\n비밀번호를 확인해주세요!', verticalPadding: 0.2, editTitle: true),
            Image.asset(
              'asset/img/knu_homes_logo_basic.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            UserInputBox(labelText: '비밀번호', isPassword: true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            UserLoginRegisterButton(
              buttonText: '다음',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPageEditAndSecession()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
