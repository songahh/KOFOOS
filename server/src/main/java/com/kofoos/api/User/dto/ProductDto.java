package com.kofoos.api.User.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class ProductDto implements Comparable<ProductDto>{
    private String productUrl; // 이미지 URL
    private String productItemNo; // 제품 Item No
    private LocalDateTime date;

    @Override
    public int compareTo(ProductDto o) {
        return this.date.compareTo(o.date);
    }

    // 생성자, 게터, 세터 등은 Lombok @Data와 @Builder가 자동으로 처리
}

