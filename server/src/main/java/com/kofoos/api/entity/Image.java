package com.kofoos.api.entity;


import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "image_id")
    private int id;

    @Column(length = 100)
    private String imgUrl;

    @OneToOne(mappedBy = "image",fetch = FetchType.LAZY)
    private WishlistItem wishlistItem;

    @OneToOne(mappedBy = "image",fetch = FetchType.LAZY)
    private Product product;

    @Builder
    public Image(String imgUrl){
        this.imgUrl = imgUrl;
    }

    public void setWishlistItem(WishlistItem wishlistItem){
        this.wishlistItem = wishlistItem;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
