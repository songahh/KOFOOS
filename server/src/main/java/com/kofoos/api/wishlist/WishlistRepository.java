package com.kofoos.api.wishlist;

import com.kofoos.api.entity.WishlistItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WishlistRepository extends JpaRepository<WishlistItem, Long> {

  /*  @Query("SELECT u FROM User u WHERE u.age >= :age")
    List<User> findByAgeGreaterThanEqual(@Param("age") Integer age);

    @Query("SELECT u FROM User u WHERE u.age >= :age")
    List<User> findByAgeGreaterThanEqual(@Param("age") Integer age);
    @Query("SELECT u FROM User u WHERE u.age >= :age")
    List<User> findByAgeGreaterThanEqual(@Param("age") Integer age);*/


}