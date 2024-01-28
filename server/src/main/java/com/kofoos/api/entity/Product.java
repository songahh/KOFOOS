package com.kofoos.api.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
public class Product {

    @Id
    @GeneratedValue
    @Column(name = "product_id")
    private Long id;

    @Column(length = 45)
    private String  barcode;

    @Column(length = 255)
    private String  name;

    @Column(length = 600)
    private String  description;

    private byte[] image;

    @Column(name = "good")
    private int like;

    @Column(name = "hit")
    private int hit;

    @Column(length = 10)
    private String convenienceStore;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToOne(mappedBy = "product")
    private WishlistItem wishlistItem;

    @OneToOne(mappedBy = "product")
    private History history;

    @OneToMany(mappedBy = "product")
    private List<ProductMaterial> productMaterials = new ArrayList<>();

    @OneToMany(mappedBy = "product")
    private List<EditorProductsList> editorProductsLists = new ArrayList<>();

}
