package com.kofoos.api.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Product {

    @Id
    @GeneratedValue
    @Column(name = "disliked_material_details_id")
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

    @Builder
    public Product(String barcode, String name, String description, byte[] image, int like, int hit, String convenienceStore, Category category) {
        this.barcode = barcode;
        this.name = name;
        this.description = description;
        this.image = image;
        this.like = like;
        this.hit = hit;
        this.convenienceStore = convenienceStore;
        setCategory(category);
    }

    @Builder
    public void setCategory(Category category) {
        this.category = category;
        category.getProducts().add(this);
    }

    public void setHistory(History history) {
        this.history = history;
    }

    public void setWishlistItem(WishlistItem wishlistItem){
        this.wishlistItem = wishlistItem;
    }

    public void addLike(){
        this.like += 1;
    }
    public void subLike(){
        this.like -= 1;
    }

    public void addHit(){
        this.hit += 1;
    }


}
