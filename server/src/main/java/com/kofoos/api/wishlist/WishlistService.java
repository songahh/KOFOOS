package com.kofoos.api.wishlist;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.common.dto.WishlistFolderDto;

import java.util.List;

public interface WishlistService {
    void like(int productId, String deviceId);

    void moveItem();
    void moveItems();

    void cancel(int productId, String deviceId);


    void check(int itemId, Integer bought);

    void create(String folderName, String deviceId);

    void delete(Integer folderId, String deviceId);

    List<WishlistFolderDto> findFolderList(String deviceId);

    List<ProductDto> findFolder(int folderId);
}
