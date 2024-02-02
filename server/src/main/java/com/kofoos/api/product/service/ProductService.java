package com.kofoos.api.product.service;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.entity.Product;
import com.kofoos.api.product.dto.ProductDetailDto;
import com.kofoos.api.product.repository.ProductRepository;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public ProductDetailDto findProductByBarcode(String barcode){
        System.out.println("barcode = " + barcode);
        Optional<Product> optional = productRepository.findProductByBarcode(barcode);
        if(optional.isEmpty()){
            throw new EntityNotFoundException();
        }
        return ProductDetailDto.of(optional.get());
    }

    public void upHit(int id){
        productRepository.UpHit(id);
    }

    public List<Product> findProductsOrder(int id, String order){
        if(order.equals("좋아요")){
            return productRepository.findProductsOrderByLike(id);
        }
        else{
            return productRepository.findProductsOrderByHit(id);
        }
    }

}
