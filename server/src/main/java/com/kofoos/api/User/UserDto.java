package com.kofoos.api.User;

import jakarta.persistence.*;

@Table(name = "uaser")
@Entity
public class UserDto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(length = 255, nullable = false)
    private String deviceId;
    @Column(length = 255, nullable = false)
    private String language;
}
