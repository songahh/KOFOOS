package com.kofoos.api.common.dto;

import com.kofoos.api.entity.*;
import lombok.Builder;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Data
@Builder
public class ProductDto {

    private int id;
    private String barcode;
    private String name;
    private String description;
    private ImageDto imageDto;
    private int like;
    private int hit;
    private String convenienceStore;


    public static ProductDto of(Product product) {

//        List<ProductMaterialDto> productMaterialDtos = new ArrayList<>();
//        List<EditorProductListDto> editorProductsListDtos = new ArrayList<>();
//
//        for(ProductMaterial productMaterial : product.getProductMaterials()){
//            productMaterialDtos.add(ProductMaterialDto.of(productMaterial));
//        }
//
//        for(EditorProductsList editorProductsList : product.getEditorProductsLists()){
//            editorProductsListDtos.add(EditorProductsListDto.of(editorProductsList));
//        }


        return ProductDto.builder()
                .barcode(product.getBarcode())
                .name(product.getName())
//                .imageDto(ImageDto.of(product.getImage()))
//                .like(product.getLike())
//                .hit(product.getHit())
//                .convenienceStore(product.getConvenienceStore())
//                .categoryDto(CategoryDto.of(product.getCategory()))
//                .wishlistItemDto(WishlistItemDto.of(product.getWishlistItem()))
//                .historyDto(HistoryDto.of(product.getHistory()))
//                .productMaterialDtos(productMaterialDtos)
//                .editorProductsListDtos(editorProductsListDtos)
                .build();

    }

}
