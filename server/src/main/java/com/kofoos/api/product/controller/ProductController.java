package com.kofoos.api.product.controller;

import com.kofoos.api.entity.Product;
import com.kofoos.api.product.dto.ProductDetailDto;
import com.kofoos.api.product.service.CategoryService;
import com.kofoos.api.product.service.ProductService;
import jakarta.transaction.Transactional;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/products")
@Slf4j
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final CategoryService categoryService;

    @GetMapping("/detail/{barcode}")
    public ResponseEntity<?> productDetail(@PathVariable String barcode){
        ProductDetailDto productDetailDto = productService.findProductByBarcode(barcode);
        return new ResponseEntity<>(productDetailDto, HttpStatus.OK);
    }

    @Transactional
    @PutMapping("/update/{id}")
    public void updateHit(@PathVariable int id){
        System.out.println("+++++++++++++++id = " + id);
        productService.upHit(id);
        return;
    }

    @GetMapping("/category/{cat1}")
    public ResponseEntity<?> getCat2(@PathVariable String cat1){
        List<String> cat2List = categoryService.findCat2(cat1);
        return new ResponseEntity<>(cat2List,HttpStatus.OK);
    }

    @GetMapping("/category/{cat1}/{cat2}")
    public ResponseEntity<?> getCat3(@PathVariable String cat1,@PathVariable String cat2){
        List<String> cat3List = categoryService.findCat3(cat1,cat2);
        return new ResponseEntity<>(cat3List,HttpStatus.OK);
    }

    @GetMapping("/category/ranking")
    public ResponseEntity<?> ranking(){
        List<String> rankList = categoryService.ranking();
        return new ResponseEntity<>(rankList,HttpStatus.OK);
    }

    @GetMapping("/list/{id}/{order}")
    public ResponseEntity<?> findProductsOrder(@PathVariable int id, @PathVariable String order){
        List<Product> products = productService.findProductsOrder(id,order);
        return new ResponseEntity<>(products,HttpStatus.OK);
    }


}
