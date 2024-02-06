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
    private String productUrl;

    public HistoryDto(int id, LocalDateTime viewTime, int user, String productUrl) {
        this.id = id;
        this.viewTime = viewTime;
        this.user = user;
        this.productUrl = productUrl;
    }

    public static HistoryDto of(History history){

        return HistoryDto.builder()
                .user(history.getUser().getId())
                .productUrl(history.getProduct().getImage().getImgUrl())
                .build();
    }


}
