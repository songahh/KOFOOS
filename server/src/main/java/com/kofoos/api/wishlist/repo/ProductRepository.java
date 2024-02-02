package com.kofoos.api.wishlist.repo;

import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.WishlistFolder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Long> {

    Optional<Product> findById(int id);

}
