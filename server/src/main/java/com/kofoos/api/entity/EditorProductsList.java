package com.kofoos.api.entity;
import jakarta.persistence.*;

@Entity
@Table(name = "editor_products_list")
public class EditorProductsList {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "article_id")
    private EditorRecommendationArticle editorRecommendationArticle;
    // Getters and Setters
}