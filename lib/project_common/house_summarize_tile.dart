import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import 'package:knu_homes/request/houser_list_request.dart';
import '../const/MyColor.dart';
import '../main_service/house_detail.dart';

Widget houseSummarizeTile(BuildContext context, bool isPaddingNeed, Map<String, dynamic> snapshot) {
  if (isPaddingNeed)
    return Padding(
      padding: EdgeInsets.fromLTRB(
          myFWidth(context, 0.06),
          myFWidth(context, 0.05),
          myFWidth(context, 0.06),
          myFWidth(context, 0.03)),
      child: Container(
          width: myFWidth(context, 0.2),
          decoration: BoxDecoration(
            color: MY_GREY,
            borderRadius: BorderRadius.circular(myFWidth(context, 0.03)),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: myFWidth(context, 0.03)),
                child: Image.network(
                  snapshot['thumbnail'],
                  width: myFWidth(context, 0.15),
                  height: myFHeight(context, 0.15),
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('이미지를 로드할 수 없습니다.');
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      //아래 텍스트 길이 만큼 잘라서 표시하자.
                      snapshot['title'],
                      style: TextStyle(
                        fontSize: myFWidth(context, 0.042),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      //아래 텍스트 길이 만큼 잘라서 표시하자.
                      snapshot['content'],
                      style: TextStyle(
                        fontSize: myFWidth(context, 0.035),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  else
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HouseDetail(
              houseId: snapshot['id'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: myFWidth(context, 0.2),
            decoration: BoxDecoration(
              color: MY_GREY,
              borderRadius: BorderRadius.circular(myFWidth(context, 0.03)),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: myFWidth(context, 0.03)),
                  child: Image.network(
                    snapshot['thumbnail'] ?? "https://2024-hackathon-homes.s3.ap-northeast-2.amazonaws.com/item/default.png",
                    width: myFWidth(context, 0.15),
                    height: myFHeight(context, 0.15),
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('이미지를 로드할 수 없습니다.');
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        //아래 텍스트 길이 만큼 잘라서 표시하자.
                        snapshot['title'],
                        style: TextStyle(
                          fontSize: myFWidth(context, 0.042),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        //아래 텍스트 길이 만큼 잘라서 표시하자.
                        snapshot['content'],
                        style: TextStyle(
                          fontSize: myFWidth(context, 0.035),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
}
