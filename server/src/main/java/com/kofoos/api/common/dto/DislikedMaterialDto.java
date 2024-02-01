package com.kofoos.api.common.dto;

import com.kofoos.api.entity.DislikedMaterial;
import com.kofoos.api.entity.DislikedMaterialDetails;
import com.kofoos.api.entity.ProductMaterial;
import com.kofoos.api.entity.UserDislikesMaterial;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
public class DislikedMaterialDto {

    private String name;
    private List<ProductMaterialDto> productMaterialDtos;
    private List<UserDislikesMaterialDto> userDislikesMaterialDtos;
    private List<DislikedMaterialDetailsDto> dislikedMaterialDetailsDtos;

    public static DislikedMaterialDto of(DislikedMaterial dislikedMaterial){

        List<ProductMaterialDto> productMaterialDtos = new ArrayList<>();
        List<DislikedMaterialDetailsDto> dislikedMaterialDetailsDtos = new ArrayList<>();
        List<UserDislikesMaterialDto> userDislikesMaterialDtos = new ArrayList<>();

        for(ProductMaterial productMaterial : dislikedMaterial.getProductMaterials()){
            productMaterialDtos.add(ProductMaterialDto.of(productMaterial));
        }

        for(DislikedMaterialDetails dislikedMaterialDetails : dislikedMaterial.getDislikedMaterialDetailsList()){
            dislikedMaterialDetailsDtos.add(DislikedMaterialDetailsDto.of(dislikedMaterialDetails));
        }

        for(UserDislikesMaterial userDislikesMaterial : dislikedMaterial.getUserDislikesMaterials()){
            userDislikesMaterialDtos.add(UserDislikesMaterialDto.of(userDislikesMaterial));
        }

        return DislikedMaterialDto.builder()
                .name(dislikedMaterial.getName())
                .productMaterialDtos(productMaterialDtos)
                .dislikedMaterialDetailsDtos(dislikedMaterialDetailsDtos)
                .userDislikesMaterialDtos(userDislikesMaterialDtos)
                .build();

    }

}
