import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/riverpod_provider/filter_provider.dart';
import 'filter_title.dart';

class FiltersSingleSidertile extends ConsumerStatefulWidget {
  final String filterName;

  const FiltersSingleSidertile({
    required this.filterName,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FiltersSingleSidertile> createState() => _FiltertileState();
}

class _FiltertileState extends ConsumerState<FiltersSingleSidertile> {
  @override
  Widget build(BuildContext context) {
    final MontlyFeeVal = ref.watch(monthlyFeeProvider);

    final depositValue = ref.watch(depositValueProvider);

    TextStyle _textStyle = TextStyle(
      fontSize: myFWidth(context, 0.04),
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );

    bool isMonthlyFee = widget.filterName == '월세';

    double min = isMonthlyFee ? 0 : 0;
    double max = isMonthlyFee ? 100 : 1000;
    double sliderValue = isMonthlyFee ? MontlyFeeVal : depositValue;

    final startProvider = isMonthlyFee
        ? monthlyFeeProvider
        : depositValueProvider;

    return ListTile(
      title: FilterTitle(
        filterName: widget.filterName,
        isNeedValueShow: true,
        isNeedSingleValueShow: true,
        startValue: sliderValue,
      ),
      subtitle: Column(
        children: [
          Slider(
            activeColor: MY_BLUE,
            value : sliderValue,
            onChanged: (double value) {
              value = value.roundToDouble();
              ref.read(startProvider.notifier).update((state) => value);
              setState(() {}); // 화면 갱신을 위해 추가
              print('the singleSligder Val : $value');
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