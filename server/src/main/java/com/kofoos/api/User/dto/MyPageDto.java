package com.kofoos.api.User.dto;

import com.kofoos.api.common.dto.DislikedMaterialDto;
import com.kofoos.api.common.dto.HistoryDto;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
public class MyPageDto {
    private String language;
    private List<String> dislikedMaterials;
    private List<Integer> products;
    private List<Integer> users;

    @Builder
    public MyPageDto(String language, List<String> dislikedMaterials, List<Integer> products,List<Integer> users) {
        this.language = language;
        this.dislikedMaterials = dislikedMaterials;

    }
}
