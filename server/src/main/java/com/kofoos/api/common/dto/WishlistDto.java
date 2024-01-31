package com.kofoos.api.common.dto;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class WishlistDto {
    private int id;
    private int bought;
    private int productId;
    private int folderId;
    private String imageId;

    @Builder
    public WishlistDto(int id, int bought, int productId, int folderId, String imageId) {
        this.id = id;
        this.bought = bought;
        this.productId = productId;
        this.folderId = folderId;
        this.imageId = imageId;
    }
}
