class WishlistDetectionDto {
  final String? itemNo;
  final String imageUrl;

  WishlistDetectionDto({required this.itemNo, required this.imageUrl});

  @override
  String toString() {
    return 'itemNo: $itemNo, imageUrl: $imageUrl';
  }


}
