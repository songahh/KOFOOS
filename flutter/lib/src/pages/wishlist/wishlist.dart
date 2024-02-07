import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../root/root_controller.dart';
import 'api/model/FolderDto.dart';
import 'api/wishlist_api.dart';

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

  // 이미지 클릭시 호출 함수
  void _onImageTapped(int productId) {
    setState(() {
      if (_selectedItems.contains(productId)) {
        _selectedItems.remove(productId); // Remove the item if it exists
      } else {
        _selectedItems.add(productId); // Add the item if it doesn't exist
      }
    });
  }

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
  }

  Future<void> updateWishlistBought() async {
    try {
      await wishlistApi.sendSelectedItemsToServer(_selectedItems);
    } catch (e) {
      print('위시리스트 제품 구매여부 변환 실패: $e');
    }
  }

  Widget _buildTabBar() {
    return TabBar(
      tabs: folderList.map((folder) => Tab(text: folder.folderName)).toList(),
    );
  }

  void _toggleEditing() {
    print('편집버튼 !');
    var rootController = Get.find<RootController>();
    rootController.isEditing.value = !rootController.isEditing.value;
    if (rootController.isEditing.value) {
      setState(() {
        _selectedItems.clear();
      });
    } // UI를 갱신하도록 setState 호출
  }

  Widget _buildGridItem(FolderDto folder, int index) {
    final int productId = folder.items[index].wishlistItemId;
    final bool isSelected = _selectedItems.contains(productId);

    // Obx를 사용하여 isEditing 상태에 따라 위젯을 업데이트합니다.
    return Obx(() {
      bool isEditingMode = Get.find<RootController>().isEditing.value;

      return GestureDetector(
        onTap: isEditingMode
            ? () {
                setState(() {
                  if (isSelected) {
                    _selectedItems.remove(productId);
                  } else {
                    _selectedItems.add(productId);
                  }
                });
              }
            : null,
        child: Stack(
          children: [
            Image.network(
              folder.items[index].imageUrl,
              width: 102.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            if (isSelected && isEditingMode)
              Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
          ],
        ),
      );
    });
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
        Container(
          height: 70,
          color: Color(0xff343F56),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  ' Wishlist',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        DefaultTabController(
          length: folderList.length,
          initialIndex: 0,
          child: Column(
            children: [
              _buildTabBar(), // TabBar
              _buildItemCountAndEditButton(), // Add this line
              Container(
                height: 900,
                child: _buildTabBarView(), // TabBarView
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _wishlistFolderButton(BuildContext context) {
    return Positioned(
      bottom: 100.0,
      right: 30.0,
      child: FloatingActionButton(
        onPressed: () {
          print('위시리스트 폴더 수정 기능 추가 필요');
        },
        child: Icon(Icons.folder),
        backgroundColor: Color(0xffECECEC),
        foregroundColor: Color(0xff343F56),
      ),
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
          IconButton(
            icon:
                Icon(Icons.check_circle_outline_outlined, color: Colors.white),
            onPressed: () {
              // 폴더 이동 로직 구현
              updateWishlistBought();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              // 삭제 로직 구현
            },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: Obx(
        () => Visibility(
          visible: rootController.isEditing.isTrue,
          child: _buildEditingBottomBar(context),
          replacement: SizedBox.shrink(), // `null` 대신 사용될 위젯
        ),
      ), // Obx를 사용하여 BottomNavigationBar 추가
    );
  }

  Widget _purchaseSelectedItems() {
    // 메인 액션 버튼을 위한 위젯
    return FloatingActionButton(
      onPressed: () {
        print('업로드 기능 추가 필요');
        // 업로드 기능 구현
      },
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
