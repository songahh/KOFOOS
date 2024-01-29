package com.kofoos.api.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Table(name = "wishlist_nonItem")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class WishlistNonItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "wishlist_nonitem_id")
    private Long id;

    @Column(name = "image_url")
    private String imageUrl;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "wishlist_folder_id")
    private WishlistFolder wishlistFolder;

    @Builder
    public WishlistNonItem(String imageUrl, WishlistFolder wishlistFolder) {
        this.imageUrl = imageUrl;
        setWishlistFolder(wishlistFolder);
    }

    private void setWishlistFolder(WishlistFolder wishlistFolder) {
        this.wishlistFolder = wishlistFolder;
        wishlistFolder.getWishlistNonItems().add(this);
    }
}