package com.kofoos.api.common.dto;

import com.kofoos.api.entity.DislikedMaterial;
import com.kofoos.api.entity.DislikedMaterialDetails;
import jakarta.persistence.Column;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DislikedMaterialDetailsDto {

    private String detailName;
    private DislikedMaterialDto dislikedMaterialDto;


    public static DislikedMaterialDetailsDto of(DislikedMaterialDetails dislikedMaterialDetails) {

        return DislikedMaterialDetailsDto.builder()
                .detailName(dislikedMaterialDetails.getDetailName())
                .dislikedMaterialDto(DislikedMaterialDto.of(dislikedMaterialDetails.getDislikedMaterial()))
                .build();
    }
}
