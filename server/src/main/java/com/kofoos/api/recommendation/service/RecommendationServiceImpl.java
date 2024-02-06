package com.kofoos.api.recommendation.service;

import com.kofoos.api.entity.Category;
import com.kofoos.api.entity.Product;
import com.kofoos.api.product.repository.ProductRepository;

import com.kofoos.api.recommendation.RecommendationException;
import com.kofoos.api.recommendation.dto.RecommendationDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecommendationServiceImpl implements RecommendationService {

    private final ProductRepository pr;
    private final Integer randomSeed;

    @Transactional(readOnly = true)
    @Override
    public List<RecommendationDto> getRelatedProductsByCategory(int productId) {
        // 1. 아이템의 카테고리를 찾는다.
        Product searchedProduct = pr.findById(productId).orElseThrow(()->new RecommendationException("item이 존재하지 않습니다."));
        Category category = searchedProduct.getCategory();

        // 2. 해당 카테고리에 해당하는 아이템을 랜덤으로 최대 10개까지 보낸다
        List<RecommendationDto> recommendationDtos = pr.findProductsOrderByRandom(category.getId(), randomSeed).stream().map((entity)-> RecommendationDto.of(entity)).toList();
        return recommendationDtos;
    }
}
