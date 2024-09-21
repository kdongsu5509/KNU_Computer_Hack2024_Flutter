import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../reactSize.dart';

/**
 * 필터 제목을 표시.
 *
 * isLonely가 true이면 padding이 적용된 필터 제목 표시.
 * isLonely가 false이면 padding이 적용되지 않은 필터 제목 표시.
 *
 */

class FilterTitle extends ConsumerStatefulWidget {
  final String filterName; // 필터 제목
  final double fontSize; // 폰트 크기
  final bool isLonely; // 패딩 여부
  final bool isNeedValueShow; // 값 표시 여부
  final bool isNeedSingleValueShow; // 단일 값 표시 여부
  var startValue;
  var endValue;

  FilterTitle({
    required this.filterName,
    this.fontSize = 0.042,
    this.isLonely = false,
    this.isNeedValueShow = false,
    this.isNeedSingleValueShow = false,
    this.startValue,
    this.endValue,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FilterTitle> createState() => _FilterTitleState();
}

class _FilterTitleState extends ConsumerState<FilterTitle> {
  @override
  Widget build(BuildContext context) {
    late Widget returnedWidget;

    // 값 표시가 필요하지 않은 경우
    if (!widget.isNeedValueShow) {
      returnedWidget = Padding(
        padding: widget.isLonely
            ? EdgeInsets.symmetric(horizontal: myFWidth(context, 0.03))
            : EdgeInsets.zero,
        child: Text(
          widget.filterName,
          style: TextStyle(fontSize: myFWidth(context, widget.fontSize), fontWeight: FontWeight.bold),
        ),
      );
    } else {
      if(widget.isNeedSingleValueShow){
        returnedWidget = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.filterName,
              style: TextStyle(fontSize: myFWidth(context, widget.fontSize,), fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _valueContainer(widget.startValue.toInt().toString()),
              ],
            ),
          ],
        );
      }
      else returnedWidget = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.filterName,
            style: TextStyle(fontSize: myFWidth(context, widget.fontSize,), fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _valueContainer(widget.startValue.toInt().toString()),
              Text(
                ' ~ ',
                style: TextStyle(
                  fontSize: myFWidth(context, 0.04),
                  fontWeight: FontWeight.bold,
                ),
              ),
              _valueContainer(widget.endValue.toInt().toString()),
            ],
          ),
        ],
      );
    }
    return returnedWidget;
  }

  // 값을 표시하는 컨테이너 생성 함수
  Widget _valueContainer(String value) {
    return Container(
      width: myFWidth(context, 0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
      ),
    );
  }
}