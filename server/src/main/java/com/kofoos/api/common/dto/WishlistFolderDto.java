package com.kofoos.api.common.dto;

import com.kofoos.api.entity.User;
import com.kofoos.api.entity.WishlistFolder;
import com.kofoos.api.entity.WishlistItem;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
public class WishlistFolderDto {

    private int id;
    private String name;
    private UserDto userDto;
    private List<WishlistItemDto> wishlistItemDtos;

    public static WishlistFolderDto of(WishlistFolder wishlistFolder){

        List<WishlistItemDto> wishlistItemDtos = new ArrayList<>();

        for(WishlistItem wishlistItem : wishlistFolder.getWishlistitems()){
            wishlistItemDtos.add(WishlistItemDto.of(wishlistItem));
        }

        return WishlistFolderDto.builder()
                .name(wishlistFolder.getName())
                .userDto(UserDto.of(wishlistFolder.getUser()))
                .wishlistItemDtos(wishlistItemDtos)
                .build();

    }

}
