import 'package:flutter/material.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectorBeanJustShow extends ConsumerStatefulWidget {
  final String selectorName;
  final StateProvider provider;
  final int type;
  StateProvider? provider2;
  // 0 : to null / 1 : to zero and to one_hundred / 2 : to zero and to one_thousand / 3 : to String(YYYY/MM/DD)

  SelectorBeanJustShow({
    required this.selectorName,
    required this.provider,
    required this.type,
    this.provider2 = null,
    Key? key,
  }) : super(key: key);

  @override
  _SelectorBeanState createState() => _SelectorBeanState();
}


class _SelectorBeanState extends ConsumerState<SelectorBeanJustShow> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: _paddingInfo(context: context),
      child: GestureDetector(
        onTap: () {
          if(widget.type == 0){
            ref.read(widget.provider.notifier).update((state) {
              return null;
            });
          }
          else if(widget.type == 1){
            ref.read(widget.provider.notifier).update((state) {
              return 0;
            });
            ref.read(widget.provider2!.notifier).update((state) {
              return 100;
            });
          }
          else if(widget.type == 2){
            ref.read(widget.provider.notifier).update((state) {
              return 100;
            });
            ref.read(widget.provider2!.notifier).update((state) {
              return 1000;
            });
          }
          else{
            ref.read(widget.provider.notifier).update((state) {
              return 'YYYY/MM/DD';
            });
          }
        },
        child: Container(
          // width:myFWidth(context, 0.05)*
          //     widget.selectorName.length,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MY_MID_GREY,
          ),
          child: Text(
            '${widget.selectorName}  x ',
            style: TextStyle(
              color: Colors.white,
              fontSize: myFWidth(context, 0.035),
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
      myFWidth(context, 0.01),
      myFWidth(context, 0.015),
      myFWidth(context, 0.01),
      myFWidth(context, 0.015),
    );
  }
}
