package com.kofoos.api.history.repository;

import com.kofoos.api.entity.History;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HistoryRepository extends JpaRepository<History, Integer> {

//    @Query("select h from History h where h.")


    @Query("SELECT h FROM History h JOIN h.user u where u.deviceId = :deviceId order by h.viewTime desc")
    List<History> HistoryDetail(String deviceId);


    void removeHistoryById(int id);

}
