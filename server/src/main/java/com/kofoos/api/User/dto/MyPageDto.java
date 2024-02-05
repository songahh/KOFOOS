package com.kofoos.api.User.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
public class MyPageDto {
    private String language;
    private List<String> dislikedMaterials;
    private List<Integer> products;

    @Builder
    public MyPageDto(String language, List<String> dislikedMaterials, List<Integer> products) {
        this.language = language;
        this.dislikedMaterials = dislikedMaterials;
        this.products = products;

    }
}
