package com.kofoos.api.wishlist.repo;

import com.kofoos.api.common.dto.ProductDto;
import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.User;
import com.kofoos.api.entity.WishlistFolder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
public interface FolderRepository extends JpaRepository<WishlistFolder, Integer> {
    @Query("SELECT wf FROM WishlistFolder wf " +
            "JOIN wf.user u " +
            "WHERE u.id = :userId AND wf.name = :name")
    Optional<WishlistFolder> findFolderByUserIdAndName(
            @Param("userId") int userId,
            @Param("name") String name
    );

    @Query("SELECT wf FROM WishlistFolder wf WHERE wf.user.id = :userId")
    List<WishlistFolder> findFolderByUserId(@Param("userId") int userId);


    @Query("SELECT p FROM Product p JOIN WishlistItem w ON p.id = w.product.id WHERE w.wishlistFolder.id = :folderId")
    List<Product> findProductsByFolderId(@Param("folderId") int folderId);



}
