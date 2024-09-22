import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/default_frame.dart';
import 'package:knu_homes/riverpod_provider/user_info_provider.dart';
import 'package:knu_homes/user/view/signup/usr_signup_d.dart';
import '../../../project_common/page_title_box.dart';
import '../../common/user_info_input_box.dart';
import '../../common/user_login_register_button.dart';

class UsrSignupC extends ConsumerStatefulWidget {
  const UsrSignupC({super.key});

  @override
  ConsumerState<UsrSignupC> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends ConsumerState<UsrSignupC> {

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return DefaultFrame(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.005),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageTitleBox(
                    pageTitle: '거의 다 왔어요!',
                    verticalPadding: 0.2),
                Image.asset(
                  'asset/img/knu_homes_logo_zweidrei.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                // 드롭다운 추가
                SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                UserInfoInputBox(labelText: '  아이디', controller: controller,),
                SizedBox(height: MediaQuery.of(context).size.height * 0.245),
                UserLoginRegisterButton(
                  buttonText: '다음',
                  onPressed: () {
                    ref.read(usernameProvider.notifier).update((state) => controller.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsrSignupD()),
                    );
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