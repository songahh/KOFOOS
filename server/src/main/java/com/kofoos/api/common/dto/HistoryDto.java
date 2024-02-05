package com.kofoos.api.common.dto;

import com.kofoos.api.entity.History;
import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class HistoryDto {

    private int id;
    private LocalDateTime viewTime;
    private UserDto user;
    private ProductDto product;

    public HistoryDto(int id, LocalDateTime viewTime, UserDto user, ProductDto product) {
        this.id = id;
        this.viewTime = viewTime;
        this.user = user;
        this.product = product;
    }


    public static HistoryDto fromEntity(History entity) {
        return new HistoryDto(entity.getId(), entity.getViewTime(), UserDto.of(entity.getUser()),ProductDto.fromEntity(entity.getProduct()));
    }

    public static HistoryDto of(History history){

        return HistoryDto.builder()
                .user(UserDto.of(history.getUser()))
                .product(ProductDto.of((history.getProduct())))
                .build();
    }


}
