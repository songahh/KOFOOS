package com.kofoos.api.User.Repository;

import com.kofoos.api.entity.History;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HistoryRepository extends JpaRepository<History, Integer> {
    List<History> findByUserId(int userId);

    // 사용자 ID에 따라 최근 조회한 상품의 히스토리 10개를 찾는 메서드
    List<History> findTop10ByUserIdOrderByViewTimeDesc(int userId);

}
