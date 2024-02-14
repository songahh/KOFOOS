import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../common/device_controller.dart';
import 'model/FolderDto.dart';

class WishlistApi {
  final DeviceController deviceController = Get.find<DeviceController>();
  var wishlistDio = Dio(
    BaseOptions(
      baseUrl: "http://i10a309.p.ssafy.io:8080",
      connectTimeout: 50000,
      receiveTimeout: 50000,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    ),
  );

  Future<List<FolderDto>> getWishlistFolder() async {
    try {
      var response = await wishlistDio.post('/wishlist/folder/list', data: {"deviceId": "rayeon"});

      if (response.statusCode == 200) {
        // 첫 번째 단계: 전체 응답을 JSON 객체로 파싱
        Map<String, dynamic> decodedResponse = response.data;

        // 두 번째 단계: "folderList" 키를 가진 값을 JSON 배열로 추출
        List<dynamic> folderListJson = decodedResponse['folderList'] as List<dynamic>;

        // 세 번째 단계: JSON 배열을 FolderDto 객체로 변환
        List<FolderDto> folderList = folderListJson.map((json) => FolderDto.fromJson(json)).toList();

        print(folderList.toString());

        return folderList;
      } else {
        throw Exception('Failed to load folder list');
      }
    } catch (e) {
      throw Exception('getWishlistFolder error: $e');
    }
  }
  Future<void> sendSelectedItemsToServer(Set wishlist_item_ids ) async {
    print(wishlist_item_ids);
    await wishlistDio.post('/wishlist/product/check', data: {"wishlistItemIds": wishlist_item_ids.toList(), "bought":1});
  }
  Future<void> deleteWishlistItems(Set wishlist_item_ids ) async {
    await wishlistDio.post('/wishlist/product/cancel', data: {"wishlistItemIds": wishlist_item_ids.toList()});
  }

  Future<void> restoreWishlistItems(Set wishlist_item_ids ) async {
    await wishlistDio.post('/wishlist/product/check', data: {"wishlistItemIds": wishlist_item_ids.toList(),"bought":0});
  }

  Future<void> likeWishlistItems(int productId) async {
    String currentDeviceId = deviceController.deviceId.value;
    await wishlistDio.post('/wishlist/product/like', data: {"productId": productId,"deviceId": currentDeviceId});
  }

  Future<void> unlikeWishlistItems(int productId) async {
    String currentDeviceId = deviceController.deviceId.value;
    await wishlistDio.post('/wishlist/product/unlike', data: {"productId": productId,"deviceId": currentDeviceId});
  }


}

