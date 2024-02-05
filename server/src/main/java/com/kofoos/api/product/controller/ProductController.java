package com.kofoos.api.product.controller;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.entity.Product;
import com.kofoos.api.product.dto.ProductDetailDto;
import com.kofoos.api.product.dto.RequestId;
import com.kofoos.api.product.service.CategoryService;
import com.kofoos.api.product.service.ProductService;
import com.kofoos.api.redis.RedisEntity;
import com.kofoos.api.redis.RedisService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/products")
@Slf4j
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final RedisService redisService;

    // 상품 조회 바코드
    @GetMapping("/detail/{barcode}/{deviceId}/{userId}")
    public ResponseEntity<?> findProductDetailBarcode(@PathVariable String barcode,@PathVariable String deviceId,@PathVariable int userId){
        ProductDetailDto productDetailDto = productService.findProductByBarcode(barcode);
        RedisEntity redisEntity = RedisEntity.builder()
                .barcode(barcode)
                .createdAt(LocalDateTime.now())
                .name(productDetailDto.getName())
                .imgUrl(productDetailDto.getImgurl())
                .deviceId(deviceId)
                .productId(productDetailDto.getProductId())
                .userId(userId)
                .itemNo(productDetailDto.getItemNo())
                .build();
        redisService.addRecentViewedItem(deviceId,redisEntity);
        return new ResponseEntity<>(productDetailDto, HttpStatus.OK);
    }

    // 상품 조회 아이템번호
    @GetMapping("/detail/no/{ItemNo}")
    public ResponseEntity<?> findProductDetailItemNo(@PathVariable String ItemNo){
        ProductDetailDto productDetailDto = productService.findProductByItemNo(ItemNo);
        return new ResponseEntity<>(productDetailDto, HttpStatus.OK);
    }

    // 카테고리 2 조회(카테고리 1선택)
    @GetMapping("/category/{cat1}")
    public ResponseEntity<?> getCat2(@PathVariable String cat1){
        List<String> cat2List = categoryService.findCat2(cat1);
        return new ResponseEntity<>(cat2List,HttpStatus.OK);
    }

    // 카테고리 3 조회 (카테고리 3 선택)
    @GetMapping("/category")
    public ResponseEntity<?> getCat3(@RequestParam String cat1,@RequestParam String cat2){
        List<String> cat3List = categoryService.findCat3(cat1,cat2);
        return new ResponseEntity<>(cat3List,HttpStatus.OK);
    }

    // 카테고리 랭킹
    @GetMapping("/category/ranking")
    public ResponseEntity<?> ranking(){
        List<String> rankList = categoryService.ranking();
        return new ResponseEntity<>(rankList,HttpStatus.OK);
    }

    // 상품 검색 및 정렬
    @GetMapping("/list/{cat1}/{cat2}/{cat3}/{order}")
    public ResponseEntity<?> findProductsOrder(@PathVariable String cat1,@PathVariable String cat2,@PathVariable String cat3, @PathVariable String order){
        System.out.println("cat1 = " + cat1);
        int id = categoryService.findId(cat1,cat2,cat3);
        System.out.println("id = " + id);
        List<ProductDetailDto> productDetailDtos = productService.findProductsOrder(id,order);
        return new ResponseEntity<>(productDetailDtos,HttpStatus.OK);
    }

    //테스트
    



}
