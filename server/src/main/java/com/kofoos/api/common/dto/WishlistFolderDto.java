package com.kofoos.api.common.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class WishlistFolderDto {
    private int id;
    private String name;
    private String userName;

    @Builder
    public WishlistFolderDto(int id, String name, String userName) {
        this.id = id;
        this.name = name;
        this.userName = userName;
    }
}
