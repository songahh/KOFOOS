package com.kofoos.api.entity;
import jakarta.persistence.*;

@Entity
@Table(name = "user_dislikes_material")
public class UserDislikesMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "material_id")
    private DislikedMaterial dislikedMaterial;

    // Getters and Setters
}