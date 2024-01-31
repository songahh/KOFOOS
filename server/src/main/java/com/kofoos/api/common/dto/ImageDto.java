package com.kofoos.api.common.dto;

import lombok.Builder;
import lombok.Data;

@Data
public class ImageDto {
    private int id;
    private String url;

    @Builder
    public ImageDto(int id, String url) {
        this.id = id;
        this.url = url;
    }
}
