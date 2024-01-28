package com.kofoos.api.entity;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "wishlist_folder")
public class WishlistFolder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "wishlist_folder_id")
    private Long id;

    @Column(name = "name")
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private User user;

    @OneToMany(mappedBy = "wishlistFolder")
    private List<WishlistItem> wishlistitems = new ArrayList<>();

    @OneToMany(mappedBy = "wishlistFolder")
    private List<WishlistNonItem> wishlistNonItems = new ArrayList<>();

    // Getters and Setters
}