package com.kofoos.api.wishlist;

import com.kofoos.api.wishlist.dto.FolderDto;
import com.kofoos.api.wishlist.dto.ProductDto;
import com.kofoos.api.common.dto.WishlistFolderDto;
import com.kofoos.api.wishlist.dto.WishlistDto;

import java.util.List;

public interface WishlistService {
    void like(int productId, String deviceId);

    void moveItems(List<Integer> items, int wishlistFolderId);

    void cancel(int productId, String deviceId);


   
    void create(String folderName, String deviceId);

    void delete(Integer folderId, String deviceId);

    List<FolderDto> findFolderList(String deviceId);

    List<ProductDto> findFolder(int folderId);

    void check(List<Integer> itemIds, int bought);
}
