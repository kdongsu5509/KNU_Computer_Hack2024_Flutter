import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/project_common/filter/selecotr_bean_coverter.dart';
import 'filter_title.dart';

class FilterTile extends ConsumerStatefulWidget {
  final String filterName;
  final List<String> filterElements;
  final String providerName; // T로 제네릭 설정
  final bool isDivide;

  const FilterTile({
    required this.filterName,
    required this.filterElements,
    required this.providerName,
    this.isDivide = true,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FilterTile> createState() => _FiltertileState();
}

class _FiltertileState extends ConsumerState<FilterTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FilterTitle(
        filterName: widget.filterName,
      ),
      subtitle: _elementOfSubTitle(widget.filterElements, widget.isDivide),
      onTap: null,
    );
  }

  Widget _elementOfSubTitle(List<String> filterElements, bool isDivide) {
    if (isDivide) {
      return Column(
        children: [
          Row(
            children: [
              for (int i = 0; i < 3; i++)
                SelectorBeanConverter(
                  providerName: widget.providerName,
                  selectorName: filterElements[i],
                  id: i,
                ),
            ],
          ),
          Row(
            children: [
              for (int i = 3; i < filterElements.length; i++)
                SelectorBeanConverter(
                  providerName: widget.providerName,
                  selectorName: filterElements[i],
                  id: i,
                ),
            ],
          ),
        ],
      );
    } else {
      return Row(
        children: [
          for (int i = 0; i < filterElements.length; i++)
            SelectorBeanConverter(
              providerName: widget.providerName,
              selectorName: filterElements[i],
              id: i,
            ),
        ],
      );
    }
  }
}