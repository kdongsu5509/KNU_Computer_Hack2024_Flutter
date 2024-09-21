import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:knu_homes/const/MyColor.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/riverpod_provider/filter_provider.dart';
import 'filter_title.dart'; // Date formatting package


class FilterCalendarTile extends ConsumerStatefulWidget {
  final String filterName;

  const FilterCalendarTile({
    required this.filterName,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FilterCalendarTile> createState() => _FiltertileState();
}

class _FiltertileState extends ConsumerState<FilterCalendarTile> {
  @override
  Widget build(BuildContext context) {

    final _usingProvider = (widget.filterName == '입주 가능 날짜')
        ? moveInDateProvider
        : moveOutDateProvider;

    final _usingValue = ref.watch(_usingProvider);

    return ListTile(
      title: FilterTitle(
        filterName: widget.filterName,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: myFWidth(context, 0.04)),
            child: Container(
              width: myFWidth(context, 0.3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Text(
                _usingValue,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MY_DARK_GREY,
                  fontSize: myFWidth(context, 0.035),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(
                locale: const Locale('ko', 'KR'),
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 1),
              ).then((value) {
                if (value != null) {
                  ref.read(_usingProvider.notifier).update((state) =>
                        DateFormat('yyyy-MM-dd').format(value).toString(),
                      );
                }
              });
            },
            child: Icon(
              Icons.calendar_today_outlined,
              color: Colors.black,
            ),
          ),
          SizedBox(width: myFWidth(context, 0.04)),
        ],
      ),
      onTap: null,
    );
  }
}