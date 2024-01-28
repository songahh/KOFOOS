package com.kofoos.api.entity;
import jakarta.persistence.*;

@Entity
@Table(name = "disliked_material_details")
public class DislikedMaterialDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "disliked_material_details")
    private Long id;

    @Column(length = 15, name = "detail_name")
    private String detailName;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "material_id")
    private DislikedMaterial dislikedMaterial;
    // Getters and Setters
}