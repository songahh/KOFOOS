package com.kofoos.api.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class History {

    @Id
    @GeneratedValue
    @Column(name = "history_id")
    private Long id;

    private LocalDateTime viewTime;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private User user;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @Builder
    public History(LocalDateTime viewTime, User user, Product product) {
        this.viewTime = viewTime;
    }

    private void setUser(User user) {
        this.user = user;
        user.getHistories().add(this);
    }

    private void setProduct(Product product) {
        this.product = product;
        product.setHistory(this);
    }
}
