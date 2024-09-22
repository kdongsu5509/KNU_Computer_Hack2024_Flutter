import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/default_frame.dart';
import 'package:knu_homes/request/houser_list_request.dart';
import 'package:knu_homes/riverpod_provider/user_info_provider.dart';
import 'package:knu_homes/user/view/usr_login.dart';
import '../../../a_server_info/server_url.dart';
import '../../../project_common/page_title_box.dart';
import '../../common/user_info_input_box.dart';
import '../../common/user_login_register_button.dart';

class UsrSignupD extends ConsumerStatefulWidget {
  const UsrSignupD({super.key});

  @override
  ConsumerState<UsrSignupD> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends ConsumerState<UsrSignupD> {

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final passwordController = TextEditingController();
    final nameVal = ref.watch(usernameProvider);
    final passwordVal = ref.watch(passwordProvider);
    final nicknameVal = ref.watch(nickNameProvider);
    final departmentVal = ref.watch(departmentProvider);

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
                UserInfoInputBox(labelText: '  비밀번호', controller: passwordController, isPassword: true),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                UserLoginRegisterButton(
                  buttonText: '회원가입',
                  onPressed: () async {
                    ref.read(passwordProvider.notifier).update((state) => passwordController.text);

                    print(nameVal);
                    print(passwordVal);
                    print(nicknameVal);
                    print(departmentVal);

                    try {
                      final resp = await dio.post(
                          "$baseUrl/auth/signup",
                          data: {
                            "username": nameVal,
                            "password": passwordController.text,
                            "nickname": nicknameVal,
                            "department": "컴퓨터공학과",
                          }
                      );

                      if (resp.statusCode == 201) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsrLogin()),
                        );
                      }

                      print("resp data: ${resp.data}");
                      MY_TOKEN = resp.data["accessToken"];
                    } on DioException catch (e) {
                      print(e.message);
                    }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
