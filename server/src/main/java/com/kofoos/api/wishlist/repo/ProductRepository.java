package com.kofoos.api.wishlist.repo;

import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.WishlistFolder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ProductRepository extends JpaRepository<Product, Integer> {

    Optional<Product> findById(int id);
    @Query("SELECT p, i FROM Product p JOIN p.image i WHERE p.id IN :productIds")
    List<Object[]> findProductsWithImagesByIds(@Param("productIds") List<Integer> productIds);




}
