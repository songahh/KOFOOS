package com.kofoos.api.entity;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Getter
@Table(name = "wishlist_item")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class WishlistItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "wishlist_item_id")
    private Long id;

    private Integer bought;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "folder_id")
    private WishlistFolder wishlistFolder;

    @Builder
    public WishlistItem(Integer bought, Product product, WishlistFolder wishlistFolder) {
        this.bought = bought;
        setProduct(product);
        setWishlistFolder(wishlistFolder);
    }

    private void setProduct(Product product) {
        this.product = product;
        product.setWishlistItem(this);
    }

    private void setWishlistFolder(WishlistFolder wishlistFolder) {
        this.wishlistFolder = wishlistFolder;
        wishlistFolder.getWishlistitems().add(this);
    }

    public void updatebought(int bought){
        this.bought = bought;
    }

}