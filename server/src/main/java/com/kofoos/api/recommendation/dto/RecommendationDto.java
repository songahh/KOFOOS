package com.kofoos.api.recommendation.dto;

import com.kofoos.api.entity.Product;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RecommendationDto {

    private int productId;
    private String imgUrl;

    public static RecommendationDto of(Product entity){
        return RecommendationDto.builder()
                .productId(entity.getId())
                .imgUrl((entity.getImage()==null)? null : entity.getImage().getImgUrl())
                .build();
    }

}
