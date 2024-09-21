import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/project_common/reactSize.dart';

/**
 * 차후에 Provider 적용해야함.
 */

class UserTextInputBox extends ConsumerStatefulWidget {
  final String hintText;
  final bool isNeedLong;

  const UserTextInputBox({
    required this.hintText,
    this.isNeedLong = false,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<UserTextInputBox> createState() => _UserTextInputBoxState();
}

class _UserTextInputBoxState extends ConsumerState<UserTextInputBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.04,
        MediaQuery.of(context).size.width * 0.07,
        MediaQuery.of(context).size.width * 0.04,
        MediaQuery.of(context).size.width * 0.0,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: widget.isNeedLong
              ? myFHeight(context, 0.4) // 높이 제한을 설정
              : myFHeight(context, 0.2), // 짧을 때의 높이
        ),
        child: TextFormField(
          cursorColor: Colors.black,
          maxLines: widget.isNeedLong ? null : 1, // 길게 입력할 때 제한 없음
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.07),
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.07),
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.07),
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: MY_MID_GREY, fontSize: MediaQuery.of(context).size.width * 0.035),
          ),
        ),
      ),
    );
  }
}
