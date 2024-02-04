package com.kofoos.api.history.dto;

import com.kofoos.api.entity.History;
import com.kofoos.api.product.dto.ProductDetailDto;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class HistoryProductDto {

    private ProductDetailDto productDetailDto;

    public static HistoryProductDto of(History history){
        return HistoryProductDto.builder()
                .productDetailDto(ProductDetailDto.of(history.getProduct()))
                .build();
    }

}
