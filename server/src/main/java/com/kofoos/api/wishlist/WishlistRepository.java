package com.kofoos.api.wishlist;

import com.kofoos.api.entity.WishlistItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface WishlistRepository extends JpaRepository<WishlistItem, Integer> {

    Optional<WishlistItem> findWishlistItemByWishlistFolderIdAndProductId(int wishlist_folder_id, int productId);


}