package com.kofoos.api.entity;

import jakarta.persistence.*;
import lombok.Getter;

import java.util.List;

@Entity
@Getter
public class Category {

    @Id
    @GeneratedValue
    @Column(name = "category_id")
    private Long id;

    @Column(length = 45,name = "cat_1")
    private String cat1;

    @Column(length = 45,name = "cat_2")
    private String cat2;

    @Column(length = 45,name = "cat_3")
    private String cat3;

    @OneToMany(mappedBy = "category")
    private List<Product> products;

}
