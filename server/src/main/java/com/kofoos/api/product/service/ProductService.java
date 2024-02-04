package com.kofoos.api.product.service;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.entity.Product;
import com.kofoos.api.product.dto.ProductDetailDto;
import com.kofoos.api.product.repository.ProductRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    @Transactional
    public ProductDetailDto findProductByBarcode(String barcode){
        System.out.println("barcode = " + barcode);
        Optional<Product> optional = productRepository.findProductByBarcode(barcode);
        if(optional.isEmpty()){
            throw new EntityNotFoundException();
        }
        Product product = optional.get();
        product.addHit();
        return ProductDetailDto.of(product);
    }
    @Transactional
    public ProductDetailDto findProductByItemNo(String itemNo){
        System.out.println("barcode = " + itemNo);
        Optional<Product> optional = productRepository.findProductByItemNo(itemNo);
        if(optional.isEmpty()){
            throw new EntityNotFoundException();
        }
        Product product = optional.get();
        product.addHit();
        return ProductDetailDto.of(product);
    }


    public List<ProductDetailDto> findProductsOrder(int id, String order){

        if(order.equals("좋아요")){
            List<Product> products = productRepository.findProductsOrderByLike(id);
            return products.stream().map(ProductDetailDto::of).collect(Collectors.toList());
        }
        else{
            List<Product> products = productRepository.findProductsOrderByHit(id);
            return products.stream().map(ProductDetailDto::of).collect(Collectors.toList());
        }
    }

}
