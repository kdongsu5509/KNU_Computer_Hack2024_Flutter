import 'package:flutter/material.dart';
import 'package:knu_homes/main_service/my_page/my_page_secession.dart';

import '../../project_common/customDivider.dart';
import '../../user/common/user_info_input_box.dart';
import '../../user/common/user_login_register_button.dart';

class MyPageEditAndSecession extends StatelessWidget {
  const MyPageEditAndSecession({super.key});

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
        child: SingleChildScrollView(

          child: Column(
            children: [
              CustomDivider(context: context, indent: 0.04),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: Image.network(
                  'https://see.knu.ac.kr/UPDIR/gt_teacher/gt_teacher_1440581293.jpg',
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              UserInfoInputBox(labelText: '이름', isPassword: true),
              UserInfoInputBox(labelText: '아이디', isPassword: true),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              UserLoginRegisterButton(
                buttonText: '다음',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => UsrSignupB()),
                  // );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              UserLoginRegisterButton(
                buttonText: '탈퇴하기',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPageSecession()),
                  );
                },
                isSecession: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
