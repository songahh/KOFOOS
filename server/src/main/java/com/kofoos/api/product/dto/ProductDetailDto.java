package com.kofoos.api.product.dto;

import com.kofoos.api.common.dto.CategoryDto;
import com.kofoos.api.common.dto.EditorProductsListDto;
import com.kofoos.api.common.dto.ProductMaterialDto;
import com.kofoos.api.entity.DislikedMaterial;
import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.ProductMaterial;
import lombok.Builder;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Data
@Builder
public class ProductDetailDto {

    private String barcode;
    private String name;
    private String description;
    private String itemNo;
    private int hit;
    private int like;
    private String convenienceStore;
    private CategorySearchDto categorySearchDto;
    private List<String> dislikedMaterials;
    private String imgurl;


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductDetailDto that = (ProductDetailDto) o;
        return Objects.equals(barcode, that.barcode) &&
                Objects.equals(itemNo, that.itemNo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(barcode, itemNo);
    }

    public static ProductDetailDto of(Product product) {

        List<ProductMaterial> productMaterials = product.getProductMaterials();

        List<String> dislikedMaterials = productMaterials.stream()
                .map(material -> material.getDislikedMaterial().getName())
                .collect(Collectors.toList());

        return ProductDetailDto.builder()
                .barcode(product.getBarcode())
                .name(product.getName())
                .description(product.getDescription())
                .hit(product.getHit())
                .categorySearchDto(CategorySearchDto.of(product.getCategory()))
                .convenienceStore(product.getConvenienceStore())
                .dislikedMaterials(dislikedMaterials)
                .itemNo(product.getItemNo())
                .like(product.getLike())
//                .imgurl(product.getImage().getImgUrl())
                .build();

    }

}
