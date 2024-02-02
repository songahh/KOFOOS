package com.kofoos.api.wishlist;

public interface WishlistService {
    void like(int productId, String deviceId);

    void moveItem();
    void moveItems();

    void cancel(int productId, String deviceId);
}
