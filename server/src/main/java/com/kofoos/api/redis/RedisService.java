package com.kofoos.api.redis;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
@RequiredArgsConstructor
public class RedisService {
    private final RedisTemplate<String, Object> redisTemplate;

    public void addRecentViewedItem(String deviceId, RedisEntity product) {
        String key = "recentViewed:" + deviceId;
        double score = System.currentTimeMillis();
        redisTemplate.opsForZSet().add(key, product, score);
    }

    public Set<Object> getRecentViewedItems(String deviceId) {
        String key = "recentViewed:" + deviceId;
        return redisTemplate.opsForZSet().reverseRange(key, 0, 9);
    }

}
