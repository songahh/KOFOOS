import 'dart:convert';

class WishlistDto {
  final int wishlistItemId;
  final int bought;
  final int productId;
  final String imageUrl;

  WishlistDto({required this.wishlistItemId ,required this.bought, required this.productId, required this.imageUrl});

  factory WishlistDto.fromJson(Map<String, dynamic> json) {
    return WishlistDto(
      wishlistItemId: json['wishlistItemId'],
      bought: json['bought'],
      productId: json['productId'],
      imageUrl: json['imageUrl'],
    );
  }
  @override
  String toString() {
    return 'wishlistItemId $wishlistItemId,bought: $bought, productId: $productId, imageUrl: $imageUrl';
  }

}
