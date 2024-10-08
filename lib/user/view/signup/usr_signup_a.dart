import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/default_frame.dart';
import 'package:knu_homes/user/view/signup/usr_signup_b.dart';
import 'package:knu_homes/user/view/signup/usr_signup_c.dart';
import '../../../project_common/page_title_box.dart';
import '../../../riverpod_provider/user_info_provider.dart';
import '../../common/user_info_input_box.dart';
import '../../common/user_login_register_button.dart';

class UsrSignupA extends ConsumerWidget {
  const UsrSignupA({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final controller = TextEditingController();

    final nameVal = ref.watch(nickNameProvider);

    return DefaultFrame(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.005),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageTitleBox(pageTitle: '홈즈가 처음이신가요?', verticalPadding: 0.2),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Image.asset(
                'asset/img/knu_homes_logo_basic.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              UserInfoInputBox(labelText: '닉네임', controller : controller, ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.24),
              UserLoginRegisterButton(
                buttonText: '다음',
                onPressed: () {
                  ref.read(nickNameProvider.notifier).update((state) => controller.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsrSignupC()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
