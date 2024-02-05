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
    private int user;
    private int product;

    public HistoryDto(int id, LocalDateTime viewTime, int user, int product) {
        this.id = id;
        this.viewTime = viewTime;
        this.user = user;
        this.product = product;
    }

    public static HistoryDto of(History history){

        return HistoryDto.builder()
                .user(history.getUser().getId())
                .product(history.getProduct().getId())
                .build();
    }


}
