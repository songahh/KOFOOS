package com.kofoos.api.recommendation.service;

import com.kofoos.api.recommendation.dto.RecommendationDto;

import java.util.List;


public interface RecommendationService {
    List<RecommendationDto> getRelatedProductsByCategory(int productId);
}
