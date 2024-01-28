package com.kofoos.api.entity;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "member")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    @Column(unique = true)
    private String deviceId;

    @Column(name = "language")
    private String language;

    @OneToMany(mappedBy = "user")
    private List<WishlistFolder> wishlistFolders = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<History> histories = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<UserDislikesMaterial> userDislikesMaterials = new ArrayList<>();

    // Getters and Setters
}