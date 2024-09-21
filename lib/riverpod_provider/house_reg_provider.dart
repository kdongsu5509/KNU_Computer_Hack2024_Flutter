import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class HouseRegState {
  final List<XFile> imageList;
  final String title;
  final String detailInfo;
  final String buildingName;
  final String buildingAddress;
  final bool isAgree;

  HouseRegState({
    required this.imageList,
    required this.title,
    required this.detailInfo,
    required this.buildingName,
    required this.buildingAddress,
    required this.isAgree,
  });

  HouseRegState copyWith({
    List<XFile>? imageList,
    String? title,
    String? detailInfo,
    String? buildingName,
    String? buildingAddress,
    bool? isAgree,
  }) {
    return HouseRegState(
      imageList: imageList ?? this.imageList,
      title: title ?? this.title,
      detailInfo: detailInfo ?? this.detailInfo,
      buildingName: buildingName ?? this.buildingName,
      buildingAddress: buildingAddress ?? this.buildingAddress,
      isAgree: isAgree ?? this.isAgree,
    );
  }
}

class HouseRegNotifier extends StateNotifier<HouseRegState> {
  HouseRegNotifier()
      : super(HouseRegState(
    imageList: [],
    title: '',
    detailInfo: '',
    buildingName: '',
    buildingAddress: '',
    isAgree: false,
  ));

  void updateImageList(List<XFile> images) {
    state = state.copyWith(imageList: images);
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDetailInfo(String detailInfo) {
    state = state.copyWith(detailInfo: detailInfo);
  }

  void updateBuildingName(String buildingName) {
    state = state.copyWith(buildingName: buildingName);
  }

  void updateBuildingAddress(String buildingAddress) {
    state = state.copyWith(buildingAddress: buildingAddress);
  }

  void updateIsAgree(bool isAgree) {
    state = state.copyWith(isAgree: isAgree);
  }
}

final houseRegProvider =
StateNotifierProvider<HouseRegNotifier, HouseRegState>((ref) {
  return HouseRegNotifier();
});
