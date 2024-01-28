package com.kofoos.api.entity;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "disliked_material")
public class DislikedMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "material_id")
    private Long id;

    @Column(length = 45,name = "name")
    private String name;

    @OneToMany(mappedBy = "dislikedMaterial")
    private List<ProductMaterial> productMaterials = new ArrayList<>();

    @OneToMany(mappedBy = "dislikedMaterial")
    private List<UserDislikesMaterial> userDislikesMaterialList = new ArrayList<>();

    @OneToMany(mappedBy = "dislikedMaterial")
    private List<DislikedMaterialDetails> dislikedMaterialDetails = new ArrayList<>();



}