import 'package:flutter/material.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectorBean extends ConsumerStatefulWidget {
  final String selectorName;
  final int id;
  final StateProvider providerName;
  var providerValue; // final 대신 var 또는 특정 타입으로 선언

  SelectorBean({
    required this.selectorName,
    required this.id,
    required this.providerName,
    this.providerValue,
    Key? key,
  }) : super(key: key);

  @override
  _SelectorBeanState createState() => _SelectorBeanState();
}


class _SelectorBeanState extends ConsumerState<SelectorBean> {
  @override
  Widget build(BuildContext context) {
    // gateProvider의 현재 상태 값을 읽음
    widget.providerValue = ref.watch(widget.providerName);

    // 선택된 아이디에 따라 색상을 설정
    Color _color = widget.providerValue == widget.id ? MY_BLUE : MY_DARK_GREY;

    return GestureDetector(
      onTap: () {
        print('${widget.selectorName} clicked');
        // 상태 업데이트: 선택된 아이디를 gateProvider로 업데이트
        ref.read(widget.providerName.notifier).update((state) {
          // 현재 선택된 아이디와 같으면 null로, 아니면 widget.id로 설정
          return widget.providerValue == widget.id ? null : widget.id;
        });
      },
      child: Padding(
        padding: _paddingInfo(context: context),
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.06 *
              widget.selectorName.length,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _color, // 동적으로 설정된 _color 사용
          ),
          child: Text(
            widget.selectorName,
            style: TextStyle(
              color: Colors.white,
              fontSize: myFWidth(context, 0.04),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Padding 정보를 반환하는 함수
  EdgeInsetsGeometry _paddingInfo({
    required BuildContext context,
  }) {
    return EdgeInsets.fromLTRB(
      0,
      myFWidth(context, 0.01),
      myFWidth(context, 0.01),
      myFWidth(context, 0.01),
    );
  }
}
