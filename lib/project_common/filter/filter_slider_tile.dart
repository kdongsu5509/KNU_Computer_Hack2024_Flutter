import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/riverpod_provider/filter_provider.dart';
import 'filter_title.dart';

class Filterslidertile extends ConsumerStatefulWidget {
  final String filterName;

  const Filterslidertile({
    required this.filterName,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Filterslidertile> createState() => _FiltertileState();
}

class _FiltertileState extends ConsumerState<Filterslidertile> {
  @override
  Widget build(BuildContext context) {
    final MontlyFeeStartValue = ref.watch(monthlyFeeStartValueProvider);
    final MontlyFeeEndValue = ref.watch(monthlyFeeEndValueProvider);

    final depositStartValue = ref.watch(depositStartValueProvider);
    final depositEndValue = ref.watch(depositEndValueProvider);

    TextStyle _textStyle = TextStyle(
      fontSize: myFWidth(context, 0.04),
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );

    bool isMonthlyFee = widget.filterName == '월세';

    double min = isMonthlyFee ? 0 : 0;
    double max = isMonthlyFee ? 100 : 1000;
    double start = isMonthlyFee ? MontlyFeeStartValue : depositStartValue;
    double end = isMonthlyFee ? MontlyFeeEndValue : depositEndValue;

    final startProvider = isMonthlyFee
        ? monthlyFeeStartValueProvider
        : depositStartValueProvider;
    final endProvider = isMonthlyFee
        ? monthlyFeeEndValueProvider
        : depositEndValueProvider;

    return ListTile(
      title: FilterTitle(
        filterName: widget.filterName,
        isNeedValueShow: true,
        startValue: start,
        endValue: end,
      ),
      subtitle: Column(
        children: [
          RangeSlider(
            activeColor: MY_BLUE,
            values: RangeValues(start, end),
            onChanged: (RangeValues values) {
              values = _toInt(values.start, values.end);
              ref.read(startProvider.notifier).update((state) => values.start);
              ref.read(endProvider.notifier).update((state) => values.end);
              setState(() {}); // 화면 갱신을 위해 추가
              print('startValue: $start, endValue: $end');
            },
            min: min,
            max: max,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: myFWidth(context, 0.04)),
                child: Text('${min.toInt()}', style: _textStyle),
              ),
              Padding(
                padding: EdgeInsets.only(right: myFWidth(context, 0.015)),
                child: Text('${max.toInt()}', style: _textStyle),
              ),
            ],
          ),
        ],
      ),
      onTap: null,
    );
  }
}

RangeValues _toInt(double value1, double value2) {
  return RangeValues(value1.roundToDouble(), value2.roundToDouble());
}
