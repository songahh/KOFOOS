import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kofoos/src/pages/wishlist/api/model/WishlistDto.dart';
import 'package:pytorch_lite/pigeon.dart';

import '../../root/root_controller.dart';
import '../search/api/search_api.dart';
import 'ImageScan.dart';
import 'WishlistDetectionDto.dart';
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
  int _current = 0;
  late PageController _pageController;
  SearchApi searchApi = SearchApi();
  List<ResultObjectDetection>? results;
  ImageScan imageScan = ImageScan();
  List<WishlistDetectionDto>? wishlistDetections = null;

  WishlistDetectionDto? _selectedDetection; // 선택된 이미지 정보를 저장할 변수
  bool _isButtonVisible = false; // 버튼 표시 상태를 관리할 변수
  List<WishlistDetectionDto> _checkedItems = []; // 체크된 아이템의 ID를 저장하는 리스트



  @override
  void initState() {
    super.initState();
    fetchWishlistFolders();
    _pageController = PageController(initialPage: 0);
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

  Future<String> getProductDetail(String itemNo) async {
    Map<String, dynamic> product = await searchApi.getProductDetail(itemNo);
    return product['imgurl'];
  }


  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      List<File> imageFiles = images.map((xFile) => File(xFile.path)).toList();
      results = (await imageScan.runObjectDetectionYoloV8(imageFiles))
          .cast<ResultObjectDetection>();
      // 여기에서 results를 처리합니다. 예를 들어 콘솔에 출력할 수 있습니다.

      print('이미지 크기');
      print('${imageFiles.length}');
      print('${results?.length}');
      int index = 0;
      List<WishlistDetectionDto> items = [];
      for (var result in results!) {
        if (result.score > 0.75) {
          String? itemNo = result.className?.split("_")[0];
          String imageUrl = images[index].path;

          WishlistDetectionDto item =
          WishlistDetectionDto(itemNo: itemNo!, imageUrl: imageUrl);
          items.add(item);
          index++;
          continue;
        }
        WishlistDetectionDto item =
        WishlistDetectionDto(itemNo: null, imageUrl: images[index].path);
        items.add(item);
        index++;
      }
      setState(() {
        wishlistDetections = items;
      });
    }
  }

  void _onLongPress(WishlistDetectionDto detection) {
    setState(() {
      _selectedDetection = detection;
      _isButtonVisible = true;
    });
  }

  void _onInsertPressed() {
    if (_selectedDetection != null) {
      print('Selected Image Info: ${_selectedDetection.toString()}');
      // 여기에 원하는 로직을 추가하세요. 예를 들어, 서버에 데이터를 보내는 등의 작업을 할 수 있습니다.
    }
    setState(() {
      _isButtonVisible = false; // 버튼 숨기기
    });
  }

  Widget _buildCarouselSlider() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: _buildCarouselWithResults(),
          ),
        ),
        // Positioned 이용하여 캐러셀 우측 하단에 버튼 위치 조정
        if (_isButtonVisible) // 조건부로 버튼을 표시합니다.
          Positioned(
            bottom: 16, // 캐러셀 하단부 내부 여백
            right: 16, // 캐러셀 우측 내부 여백
            child: ElevatedButton(
              onPressed: _onInsertPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // 버튼 배경 색상
                onPrimary: Colors.white, // 버튼 텍스트 색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // 버튼 모서리 둥글게
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // 내부 패딩
              ),
              child: Text(
                'INSERT',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /*Widget _buildCarouselSlider() {
    return Container(
      // Container 위젯을 사용하여 캐러셀 주변에 테두리 추가
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // 테두리 색상 설정
        borderRadius: BorderRadius.circular(8.0), // 테두리 둥근 정도 설정
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 2.0,
          enlargeCenterPage: false,
          viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        items: buildCarouselWithResults(),
      ),
    );
  }*/

  Widget _buildPhotoUploadWidget() {
    // 이미지 업로드 위젯
    return Container(
      padding: EdgeInsets.all(16.0),
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
            'AI가 진단하면 여기에 상품이 보여집니다.',
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

  // 이미지 파일 리스트를 받아 각 이미지에 대한 위젯을 생성하고 슬라이더로 구성하는 함수입니다.
  /* List<Widget> buildCarouselWithResults() {
    List<Widget> carouselItems = [];

    if (wishlistDetections == null) {
      // wishlistDetections가 null일 경우, 이미지 업로드 위젯만 추가
      carouselItems.add(_buildPhotoUploadWidget());
    } else {
      // wishlistDetections가 null이 아닐 경우, 각 탐지 결과에 대한 위젯 생성
      carouselItems.addAll(wishlistDetections!.map((wishlistDetection) {
        return Container(
          margin: EdgeInsets.all(5.0), // 주위 여백 추가
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬 추가
            children: <Widget>[
              // 왼쪽에 사용자가 업로드한 이미지
              Container(
                padding: EdgeInsets.all(8.0), // 이미지 주위 패딩 추가
                child: Image.file(
                  File(wishlistDetection.imageUrl),
                  width: 100,
                  height: 100,
                ),
              ),
              // 오른쪽에 itemNo에 해당하는 이미지 (itemNo가 있다면)
              wishlistDetection.itemNo != null
                  ? FutureBuilder<String>(
                future: getProductDetail(wishlistDetection.itemNo!),
                builder: (BuildContext context,
                    AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator(); // 로딩 인디케이터 표시
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container(
                      padding: EdgeInsets.all(8.0), // 이미지 주위 패딩 추가
                      child: Image.network(
                        snapshot.data!,
                        width: 100,
                        height: 100,
                      ),
                    );
                  }
                },
              )
                  : Container(), // itemNo가 없다면 빈 컨테이너 표시
            ],
          ),
        );
      }).toList());
    }

    // "이미지 업로드" 버튼을 마지막 항목으로 추가
    carouselItems.add(_buildPhotoUploadWidget());

    return carouselItems;
  }*/


  List<Widget> _buildCarouselWithResults() {
    List<Widget> carouselItems = [];

    if (wishlistDetections == null) {
      carouselItems.add(_buildPhotoUploadWidget());
    } else {
      carouselItems.addAll(wishlistDetections!.map((wishlistDetection) {
        return GestureDetector(
          onTap: () {
            // onTap 로직
          },
          onLongPress: () => _onLongPress(wishlistDetection),
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 이미지를 왼쪽부터 시작하도록 정렬
              children: <Widget>[
                // 사용자가 업로드한 이미지
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.file(
                    File(wishlistDetection.imageUrl),
                    width: 100,
                    height: 100,
                  ),
                ),
                // itemNo가 null이 아닌 경우에만 FutureBuilder를 사용하여 이미지 표시
                if (wishlistDetection.itemNo != null)
                  FutureBuilder<String>(
                    future: getProductDetail(wishlistDetection.itemNo!),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: Center(child: CircularProgressIndicator()),
                        ); // 로딩 인디케이터 표시
                      } else if (snapshot.hasError) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: Center(child: Text('Error: ${snapshot.error}')),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(8.0),
                          child: Image.network(
                            snapshot.data!,
                            width: 100,
                            height: 100,
                          ),
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
        );
      }).toList());
    }

    carouselItems.add(_buildPhotoUploadWidget());
    return carouselItems;
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
        _buildCarouselSlider(),
        Row(
          // 페이지 인디케이터를 위한 Row 위젯
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildCarouselWithResults().asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _pageController.animateToPage(
                entry.key,
                duration: Duration(milliseconds: 300), // 애니메이션 지속 시간
                curve: Curves.easeInOut, // 애니메이션 속도 곡선
              ),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? Theme.of(context)
                      .primaryColor // 현재 페이지에 해당하는 동그라미는 다른 색상으로
                      : Theme.of(context)
                      .primaryColor
                      .withOpacity(0.4), // 나머지 동그라미는 투명도를 낮춤
                ),
              ),
            );
          }).toList(),
        ),
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
                icon: Icon(Icons.check_circle_outline_outlined,
                    color: Colors.white),
                onPressed: updateWishlistBought,
              ),
              Text('PURCHASE',
                  style: TextStyle(color: Colors.white, fontSize: 4)),
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
              Text('RESTORE',
                  style: TextStyle(color: Colors.white, fontSize: 4)),
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
              Text('DELETE',
                  style: TextStyle(color: Colors.white, fontSize: 4)),
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
