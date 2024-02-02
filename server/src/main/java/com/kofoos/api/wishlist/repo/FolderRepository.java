package com.kofoos.api.wishlist.repo;

import com.kofoos.api.entity.User;
import com.kofoos.api.entity.WishlistFolder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface FolderRepository extends JpaRepository<WishlistFolder, Long> {
    @Query("SELECT wf FROM WishlistFolder wf " +
            "JOIN wf.user u " +
            "WHERE u.id = :userId AND wf.name = :name")
    Optional<WishlistFolder> findFolderByUserIdAndName(
            @Param("userId") int userId,
            @Param("name") String name
    );


}
