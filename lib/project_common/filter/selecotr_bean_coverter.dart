import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knu_homes/riverpod_provider/filter_provider.dart';
import '../selector_bean/selectorBean.dart';

class SelectorBeanConverter extends ConsumerStatefulWidget {
  final String providerName;
  final String selectorName;
  final int id;

  const SelectorBeanConverter({
    required this.providerName,
    required this.selectorName,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SelectorBeanConverter> createState() => _SelectorBeanConverterState();
}

class _SelectorBeanConverterState extends ConsumerState<SelectorBeanConverter> {
  @override
  Widget build(BuildContext context) {
    late Widget convertedSelectorBean;

    if (widget.providerName.compareTo('gateProvider') == 0) {
      convertedSelectorBean = SelectorBean(
        selectorName: widget.selectorName,
        id: widget.id,
        providerName: gateProvider,
      );
    } else if (widget.providerName.compareTo('maintenceBillProvider') == 0) {
      convertedSelectorBean = SelectorBean(
        selectorName: widget.selectorName,
        id: widget.id,
        providerName: maintenceBillProvider,
      );
    }
    else if (widget.providerName.compareTo('windowDirectionProvider') == 0) {
      convertedSelectorBean = SelectorBean(
        selectorName: widget.selectorName,
        id: widget.id,
        providerName: windowDirectionProvider,
      );
    }
    else if (widget.providerName.compareTo('roomCntProvider') == 0) {
      convertedSelectorBean = SelectorBean(
        selectorName: widget.selectorName,
        id: widget.id,
        providerName: roomCntProvider,
      );
    }
    else if (widget.providerName.compareTo('roomCntProvider') == 0) {
      convertedSelectorBean = SelectorBean(
        selectorName: widget.selectorName,
        id: widget.id,
        providerName: roomCntProvider,
      );
    }
    else if (widget.providerName.compareTo('roomFloorProvider') == 0) {
      convertedSelectorBean = SelectorBean(
        selectorName: widget.selectorName,
        id: widget.id,
        providerName: roomFloorProvider,
      );
    }
    return convertedSelectorBean; // 변환된 위젯 반환
  }
}
