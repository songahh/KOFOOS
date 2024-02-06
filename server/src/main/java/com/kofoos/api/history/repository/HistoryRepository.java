package com.kofoos.api.history.repository;

import com.kofoos.api.entity.History;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface HistoryRepository extends JpaRepository<History, Integer> {

//    @Query("select h from History h where h.")


    @Query("SELECT h FROM History h JOIN fetch h.user u join fetch h.product p where u.deviceId = :deviceId order by h.viewTime desc")
    List<History> HistoryDetail(String deviceId);


    void removeHistoryById(int id);

    @Modifying
    @Query(value = "insert into history(view_time, product_id, user_id) values(:viewTime, :productId, :userId)",nativeQuery = true)
    void addHistory(LocalDateTime viewTime, int productId, int userId);
}
