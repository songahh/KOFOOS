package com.kofoos.api.recommendation.controller;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.recommendation.dto.RecommendationDto;
import com.kofoos.api.recommendation.service.RecommendationService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/recommend")
@RequiredArgsConstructor
public class RecommendationController {

    private final RecommendationService rs;

    /**
    * 유사한 상품 추천 & 카테고리별 추천
    * */
    @GetMapping("/product/{product_id}")
    public List<RecommendationDto> getRelatedProductsByCategory(@PathVariable("product_id") int productId){
        return rs.getRelatedProductsByCategory(productId);
    }

    /**
     * 에디터 추천
     * */
    @GetMapping("/editor")
    public List<ProductDto> getRecommendationByEditor(){
        return null;
    }

    @GetMapping("/editor/{recommendation_article_id}")
    public List<ProductDto> getRecommendation(@PathVariable("recommendation_article_id") int rArticleId){
        return null;
    }

}
