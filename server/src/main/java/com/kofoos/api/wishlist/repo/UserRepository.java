package com.kofoos.api.wishlist.repo;
import com.kofoos.api.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    @Query("SELECT u FROM User u WHERE u.deviceId = :deviceId")
    Optional<User> findUserIdByDeviceId(@Param("deviceId") String deviceId);
}
