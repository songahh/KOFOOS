import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pytorch_lite/pigeon.dart';

import '../../root/root_controller.dart';
import 'ImageScan.dart';
import 'api/model/FolderDto.dart';
import 'api/wishlist_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  // 이미지 선택 상태를 관리하기 위한 집합
  final Set<int> _selectedItems = {};

  List<FolderDto> folderList = [];
  WishlistApi wishlistApi = WishlistApi();
  int _itemCount = 0;
  bool _isEditing = false; // 편집 모드 상태를 관리하는 변수
  List<String> _imagePaths = []; // 이미지 파일 경로를 저장할 리스트
  ImageScan imageScan = ImageScan();


  @override
  void initState() {
    super.initState();
    fetchWishlistFolders();
  }

  Future<void> fetchWishlistFolders() async {
    try {
      var folders = await wishlistApi.getWishlistFolder();
      setState(() {
        folderList = folders;
        // 모든 폴더의 아이템 수를 합산하여 _itemCount를 업데이트
        _itemCount =
            folderList.fold(0, (sum, folder) => sum + folder.items.length);
      });
    } catch (e) {
      print('폴더 목록 가져오기 실패: $e');
    }

    await imageScan.initializeModel(); // 모델 초기화
  }

  Future<void> updateWishlistBought() async {
    try {
      await wishlistApi.sendSelectedItemsToServer(_selectedItems);
      setState(() {
        fetchWishlistFolders(); // UI를 갱신하기 위해 데이터를 다시 불러옵니다.
        _selectedItems.clear();
      });
    } catch (e) {
      print('위시리스트 제품 구매여부 변환 실패: $e');
    }
  }

  Future<void> deleteWishlistItem() async {
    try {
      await wishlistApi.deleteWishlistItems(_selectedItems);
      setState(() {
        fetchWishlistFolders(); // UI를 갱신하기 위해 데이터를 다시 불러옵니다.
        _selectedItems.clear();
      });
    } catch (e) {
      print('위시리스트 제품 구매여부 변환 실패: $e');
    }
  }

  Future<void> restoreWishlistItem() async {
    try {
      await wishlistApi.restoreWishlistItems(_selectedItems);
      setState(() {
        fetchWishlistFolders(); // UI를 갱신하기 위해 데이터를 다시 불러옵니다.
        _selectedItems.clear();
      });
    } catch (e) {
      print('위시리스트 제품 구매여부 변환 실패: $e');
    }
  }



  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();



    if (images != null) {
      List<File> imageFiles = images.map((xFile) => File(xFile.path)).toList();
      List<ResultObjectDetection?> results = await imageScan.runObjectDetectionYoloV8(imageFiles);
      // 여기에서 results를 처리합니다. 예를 들어 콘솔에 출력할 수 있습니다.
      for (var result in results) {
        if (result != null) {
          print("진단 객체 ${result.className} 점수: ${result.score}");
        } else {
          print("실패용");
        }
      }
    }
  }

  Widget _buildPhotoUploadWidget() {
    // 이미지 업로드 위젯
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '이미지를 업로드하여',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Text(
            'AI가 진단하면 여기에 상품이 보여집니다.\n파일 업로드 아이콘',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _pickImages,
            child: Text('이미지 업로드'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabs: folderList.map((folder) => Tab(text: folder.folderName)).toList(),
    );
  }

  void _toggleEditing() async {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _selectedItems.clear();
      }
    });
    RootController.to.isEditing.value = _isEditing;

    if (!_isEditing) {
      if (_selectedItems.isNotEmpty) {
        await updateWishlistBought(); // 선택된 아이템을 서버에 업데이트
      }
      await fetchWishlistFolders(); // 폴더 목록을 다시 가져옴
    }
  }

  Widget _buildGridItem(FolderDto folder, int index) {
    final int wishlistItemId = folder.items[index].wishlistItemId;
    final bool isBought = folder.items[index].bought == 1;
    final bool isSelected = _selectedItems.contains(wishlistItemId);

    return GestureDetector(
      onTap: () {
        if (_isEditing) {
          setState(() {
            if (isSelected) {
              _selectedItems.remove(wishlistItemId);
            } else {
              _selectedItems.add(wishlistItemId);
            }
          });
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.network(
            folder.items[index].imageUrl,
            width: 102.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          // 구매 표시
          if (isBought) ...[
            Container(
              width: 102.0,
              height: 120.0,
              color: Colors.black.withOpacity(0.5),
            ),
            Transform.rotate(
              angle: -0.785398, // 45 degrees in radians
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'COMPLETE',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
          // 편집 모드에서의 선택 표시
          if (_isEditing)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(isSelected ? 0 : 1),
                  shape: BoxShape.circle,
                ),
                child: isSelected
                    ? Icon(Icons.check_circle_rounded,
                    color: Colors.blue) // 이미 선택된 경우 체크 아이콘 표시
                    : Container(), // 선택되지 않은 경우 회색 동그라미 표시
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    print("folderList length: ${folderList.length}");
    return TabBarView(
      children: folderList.map((folder) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: folder.items.length,
          itemBuilder: (context, index) {
            return _buildGridItem(folder, index); // 각 이미지를 선택 가능한 아이템으로 구성
          },
        );
      }).toList(),
    );
  }

  Widget _wishlistWidget(BuildContext context) {
    return Column(
      children: [

        _buildPhotoUploadWidget(),
        Stack(
          children: [
            Card(
              elevation: 2.0,
              margin: EdgeInsets.all(8.0),
              child: DefaultTabController(
                length: folderList.length,
                initialIndex: 0,
                child: Column(
                  children: [
                    _buildTabBar(),
                    _buildItemCountAndEditButton(),
                    Container(
                      height: 900,
                      child: _buildTabBarView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )

      ],
    );
  }

  Widget _buildItemCountAndEditButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'Items (${folderList.fold(0, (previousValue, folder) => previousValue + folder.items.length)})'),
          Obx(() => TextButton(
            onPressed: _toggleEditing,
            child: Text(
                Get.find<RootController>().isEditing.isTrue
                    ? 'Done'
                    : 'Edit',
                style: TextStyle(color: Colors.blue)),
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildEditingBottomBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // 첫 번째 항목: 구매
          Column(
            mainAxisSize: MainAxisSize.min, // 내용에 맞게 크기를 최소로 설정
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check_circle_outline_outlined, color: Colors.white),
                onPressed: updateWishlistBought,
              ),
              Text('PURCHASE', style: TextStyle(color: Colors.white, fontSize: 4)),
            ],
          ),
          // 두 번째 항목: 복원
          Column(
            mainAxisSize: MainAxisSize.min, // 내용에 맞게 크기를 최소로 설정
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart_sharp, color: Colors.white),
                onPressed: restoreWishlistItem,
              ),
              Text('RESTORE', style: TextStyle(color: Colors.white, fontSize: 4)),
            ],
          ),
          // 세 번째 항목: 삭제
          Column(
            mainAxisSize: MainAxisSize.min, // 내용에 맞게 크기를 최소로 설정
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: deleteWishlistItem,
              ),
              Text('DELETE', style: TextStyle(color: Colors.white, fontSize: 4)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 인스턴스를 얻습니다.
    final RootController rootController = Get.find<RootController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _wishlistWidget(context),
            Padding(
              padding: EdgeInsets.only(bottom: 80.0), // BottomAppBar에 공간을 제공
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => Visibility(
          visible: rootController.isEditing.isTrue,
          child: _buildEditingBottomBar(context),
          replacement: SizedBox.shrink(), // `null` 대신 사용될 위젯
        ),
      ), // Obx를 사용하여 BottomNavigationBar 추가
    );
  }

}
