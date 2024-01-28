package com.kofoos.api.entity;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "editor_recommendation_article")
public class EditorRecommendationArticle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "article_id")
    private Long id;

    @Column(length = 50, name = "subject")
    private String subject;

    @Column(length = 50, name = "content")
    private String content;

    @Column(name = "registration_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date registrationTime;

    @Column(name = "image")
    private String image;

    @OneToMany(mappedBy = "editorRecommendationArticle")
    private List<EditorProductsList> editorProductsList = new ArrayList<>();
    // Getters and Setters
}