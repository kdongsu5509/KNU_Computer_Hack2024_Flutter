import 'package:flutter/material.dart';
import 'package:knu_homes/project_common/reactSize.dart';
import '../const/MyColor.dart';

Widget houseSummarizeTile(BuildContext context, bool isPaddingNeed) {
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
                  "https://i.namu.wiki/i/N77FArM9VORgT4IeZTW1kBYdLlDoWrd5kllCwnusok9tQkV7cBD3b-oQkWr95jNnMFxu0s8yMhtBFUGpjqKzbw.webp",
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
                      '정문 이어살기 구합니다(나가는\n입장)200/35 월세 5만원 지원...',
                      style: TextStyle(
                        fontSize: myFWidth(context, 0.042),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      //아래 텍스트 길이 만큼 잘라서 표시하자.
                      '개인적으로 첫달 월세 5만원 지원해...',
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
    return Container(
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
                "https://i.namu.wiki/i/N77FArM9VORgT4IeZTW1kBYdLlDoWrd5kllCwnusok9tQkV7cBD3b-oQkWr95jNnMFxu0s8yMhtBFUGpjqKzbw.webp",
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
                    '정문 이어살기 구합니다(나가는\n입장)200/35 월세 5만원 지원...',
                    style: TextStyle(
                      fontSize: myFWidth(context, 0.042),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    //아래 텍스트 길이 만큼 잘라서 표시하자.
                    '개인적으로 첫달 월세 5만원 지원해...',
                    style: TextStyle(
                      fontSize: myFWidth(context, 0.035),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
}
