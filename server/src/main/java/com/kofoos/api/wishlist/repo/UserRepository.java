package com.kofoos.api.wishlist.repo;
import com.kofoos.api.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Long> {
    @Query("SELECT u.id FROM User u WHERE u.deviceId = :deviceId")
    String findUserIdByDeviceId(@Param("deviceId") String deviceId);
}
