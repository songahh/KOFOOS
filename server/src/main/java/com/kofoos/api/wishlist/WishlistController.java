package com.kofoos.api.wishlist;

import org.springframework.expression.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {


    private WishlistService wishlistService;

    public WishlistController(WishlistService wishlistService) {

        this.wishlistService = wishlistService;
    }


    /*
      상품 좋아요(위시리스트 추가)

        /wishlist/product/like
        productId : int
        deviceId: String
     */
    @ResponseBody
    @GetMapping("/product/like")
    public ResponseEntity<Map<String, Object>> likeProduct(@RequestBody Map<String, Object> req)
            throws ParseException {
        Map<String, Object> result = new HashMap<String, Object>();

        int productId = (Integer) req.get("productId");
        String deviceId = (String)  req.get("deviceId");



        wishlistService.like(productId,deviceId);


        //ok상태코드 리턴
        return new ResponseEntity<Map<String, Object>>(result, HttpStatus.OK);
    }
    /**
     * Get /products/category/ranking 카테고리 카테고리랭킹 (목록)
     * Post /product/like 상품 좋아요(위시리스트 추가)
     * Post /product/cancel 상품 좋아요 취소
     * Post /product/check\ 위시리스트 폴더 생성
     * Post /folder/create 위시리스트 폴더 생성
     * Post /folder/delete 위시리스트 폴더 삭제
     * Post /folder/list 위시리스트 폴더 조회(목록)
     * Get /folder/{wishlist_folder_id}위시리스트 상품 조회(상품)
     * Post /folder/{wishlist_folder_id}위시리스트 제품 폴더 간 이동
     *
     */



}