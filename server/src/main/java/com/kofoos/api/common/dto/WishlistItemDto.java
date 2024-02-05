package com.kofoos.api.common.dto;

import com.kofoos.api.entity.Image;
import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.WishlistFolder;
import com.kofoos.api.entity.WishlistItem;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;

@Data@Builder
public class WishlistItemDto {

    private int id;
    private Integer bought;
    private ProductDto productDto;
    private String imgurl;
    private int wishlistFolderId;

    public static WishlistItemDto of(WishlistItem wishlistItem){
        return WishlistItemDto.builder()
                .bought(wishlistItem.getBought())
                .imgurl((wishlistItem.getImage().getImgUrl()))
                .wishlistFolderId(((wishlistItem.getWishlistFolder().getId())))
                .build();
    }

}
