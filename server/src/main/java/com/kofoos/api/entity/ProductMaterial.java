package com.kofoos.api.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Table(name = "product_material")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ProductMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id")
    private DislikedMaterial dislikedMaterial;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id")
    private Product product;

    @Builder
    public ProductMaterial(DislikedMaterial dislikedMaterial, Product product) {
        setProduct(product);
        setDislikedMaterial(dislikedMaterial);
    }

    private void setProduct(Product product) {
        this.product = product;
        product.getProductMaterials().add(this);
    }

    private void setDislikedMaterial(DislikedMaterial dislikedMaterial) {
        this.dislikedMaterial = dislikedMaterial;
        dislikedMaterial.getProductMaterials().add(this);
    }
}

