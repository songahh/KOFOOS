package com.kofoos.api.wishlist;

import com.kofoos.api.entity.WishlistItem;
import com.kofoos.api.wishlist.dto.ProductDto;
import com.kofoos.api.wishlist.dto.WishlistDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WishlistRepository extends JpaRepository<WishlistItem, Integer> {

    Optional<WishlistItem> findWishlistItemByWishlistFolderIdAndProductId(int wishlist_folder_id, int productId);

    @Query("SELECT NEW com.kofoos.api.wishlist.dto.ProductDto(p.id, i.imgUrl) " +
            "FROM WishlistItem wi " +
            "JOIN wi.product p " +
            "JOIN p.image i " +
            "WHERE wi.wishlistFolder.id = :folderId")
    List<ProductDto> findProductsByFolderId(@Param("folderId") int folderId);

    @Query("SELECT new com.kofoos.api.wishlist.dto.WishlistDto(wi.id, wi.bought, wi.product.id, img.imgUrl) " +
            "FROM WishlistItem wi " +
            "JOIN wi.product p " +
            "JOIN p.image img " +
            "WHERE wi.wishlistFolder.id = :folderId")
    List<WishlistDto> findItemsWithImagesByUserId(@Param("folderId") int folderId);


    @Modifying
    @Query("UPDATE WishlistItem SET bought = :bought WHERE id = :wishlistItemId")
    int updateBought(@Param("wishlistItemId") int wishlistItemId, @Param("bought") int bought);

    @Modifying
    @Query("UPDATE WishlistItem SET wishlistFolder.id = :targetFolderId WHERE id = :itemId")
    void updateFolderId(@Param("itemId") int itemId, @Param("targetFolderId") int targetFolderId);
}
