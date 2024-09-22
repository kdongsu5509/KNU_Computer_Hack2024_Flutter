import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = StateProvider<String?>((ref) => null);

String? MY_TOKEN = null;

final usernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String?>((ref) => null);
final nickNameProvider = StateProvider<String?>((ref) => null);
final departmentProvider = StateProvider<String?>((ref) => null);