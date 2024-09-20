import 'package:flutter/material.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/project_common/default_frame.dart';
import 'package:knu_homes/const/knu_gates.dart';
import 'package:knu_homes/user/view/signup/usr_signup_c.dart';
import '../../../project_common/page_title_box.dart';
import '../../common/user_login_register_button.dart';

class UsrSignupB extends StatefulWidget {
  const UsrSignupB({super.key});

  @override
  State<UsrSignupB> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<UsrSignupB> {
  String? _selectedGate;

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                PageTitleBox(
                    pageTitle: '어디든 가까운 집을\n찾을 수 있을 거에요!',
                    verticalPadding: 0.1),
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                Image.asset(
                  'asset/img/knu_homes_logo_eindrei.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                // 드롭다운 추가
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                GateDropdown(
                  selectedGate: _selectedGate,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGate = newValue;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.245),
                UserLoginRegisterButton(
                  buttonText: '다음',
                  onPressed: () {
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
      ),
    );
  }
}

class GateDropdown extends StatelessWidget {
  final String? selectedGate;
  final ValueChanged<String?> onChanged;

  const GateDropdown({
    Key? key,
    required this.selectedGate,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: MY_GREY, // 드롭다운 버튼의 배경색 설정
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.07),
        ),
        child: DropdownButton<String>(
          value: selectedGate,
          hint: Text(
            '주 출입문',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.black,
            ),
          ),
          // 드롭다운 버튼 힌트 설정
          dropdownColor: Colors.white,
          // 드롭다운 메뉴의 배경색 설정
          isExpanded: true,
          underline: SizedBox(),
          // 기본 밑줄 제거
          items: KNU_GATES.map((gate) {
            return DropdownMenuItem<String>(
              value: gate,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(gate),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: TextStyle(color: Colors.black), // 드롭다운 버튼 텍스트 색상 설정
        ),
      ),
    );
  }
}
