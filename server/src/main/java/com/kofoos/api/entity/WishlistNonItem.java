package com.kofoos.api.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "wishlist_nonItem")
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

    // Getters and Setters
}