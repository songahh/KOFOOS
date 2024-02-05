package com.kofoos.api.wishlist.dto;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

@Data
public class WishlistDto {

    private int bought;
    private int productId;
    private String imageUrl;



    public WishlistDto(int bought, int productId, String imageUrl) {
        this.bought = bought;
        this.productId = productId;
        this.imageUrl = imageUrl;
    }
}
