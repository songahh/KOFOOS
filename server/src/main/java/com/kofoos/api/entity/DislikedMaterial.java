package com.kofoos.api.entity;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Table(name = "disliked_material")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DislikedMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "disliked_material_details_id")
    private Long id;

    @Column(length = 45,name = "name")
    private String name;

    @OneToMany(mappedBy = "dislikedMaterial")
    private List<ProductMaterial> productMaterials = new ArrayList<>();

    @OneToMany(mappedBy = "dislikedMaterial")
    private List<UserDislikesMaterial> UserDislikesMaterials = new ArrayList<>();

    @OneToMany(mappedBy = "dislikedMaterial")
    private List<DislikedMaterialDetail> dislikedMaterialDetailsList = new ArrayList<>();


    @Builder
    public DislikedMaterial(String name) {
        this.name = name;
    }

}