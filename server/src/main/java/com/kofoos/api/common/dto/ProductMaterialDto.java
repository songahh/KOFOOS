package com.kofoos.api.common.dto;

import com.kofoos.api.entity.DislikedMaterial;
import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.ProductMaterial;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProductMaterialDto {

    private int id;
    private DislikedMaterialDto dislikedMaterialDto;
    private ProductDto productDto;

    public static ProductMaterialDto of(ProductMaterial productMaterial) {
        return ProductMaterialDto.builder()
                .dislikedMaterialDto(DislikedMaterialDto.of(productMaterial.getDislikedMaterial()))
                .productDto(ProductDto.of(productMaterial.getProduct()))
                .build();
    }

}
