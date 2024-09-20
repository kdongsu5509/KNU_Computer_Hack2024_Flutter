import 'package:flutter_riverpod/flutter_riverpod.dart';

final finishContainProvider = StateProvider<bool>((ref) => false);

//문 위치
final gateProvider = StateProvider<int?>((ref) => null);

//관리비 포함 여부
final maintenceBillProvider = StateProvider<int?>((ref) => null);

//창문 방향
final windowDirectionProvider = StateProvider<int?>((ref) => null);

//방 개수
final roomCntProvider = StateProvider<int?>((ref) => null);

//층 안내
final roomFloorProvider = StateProvider<int?>((ref) => null);

//월세
final monthlyFeeStartValueProvider = StateProvider<double>((ref) => 0);
final monthlyFeeEndValueProvider = StateProvider<double>((ref) => 100);

//보증금
final depositStartValueProvider = StateProvider<double>((ref) => 0);
final depositEndValueProvider = StateProvider<double>((ref) => 1000);

//입주 가능 날짜
final moveInDateProvider = StateProvider<String>((ref) => 'YYYY/MM/DD');