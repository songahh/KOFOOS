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


    private LocalDateTime viewTime;
    private UserDto user;
    private ProductDto product;

    public static HistoryDto of(History history){

        return HistoryDto.builder()
                .user(UserDto.of(history.getUser()))
                .product(ProductDto.of((history.getProduct())))
                .build();
    }


}
