package com.kofoos.api.redis;

import com.kofoos.api.history.dto.HistoryProductDto;
import com.kofoos.api.product.dto.ProductDetailDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.util.*;
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
        //
    }

    public Set<Object> getRecentViewedItems(String deviceId) {
        String key = "recentViewed:" + deviceId;
        return redisTemplate.opsForZSet().reverseRange(key, 0, 9);
    }



    public Map<String, List<HistoryProductDto>> getAllRedisHistories() {
        Map<String, List<HistoryProductDto>> recentItems = new HashMap<>();
        Set<String> keys = redisTemplate.keys("*");
        if (keys != null) {
            keys.forEach(key -> {
                Set<Object> objects = redisTemplate.opsForZSet().reverseRange(key, 0, 9);
                objects.forEach(o -> {
                    RedisEntity redisEntity = (RedisEntity) o;
                    HistoryProductDto productDetailDto = HistoryProductDto.builder()
                            .barcode(redisEntity.getBarcode())
                            .itemNo(redisEntity.getItemNo())
//                        .imgurl(redisEntity.getImgUrl())
                            .build();
                    if(recentItems.containsKey(redisEntity.getDeviceId())){
                        recentItems.get(redisEntity.getDeviceId()).add(productDetailDto);
                    }
                    else{
                        List<HistoryProductDto> dtoList = new ArrayList<>();
                        dtoList.add(productDetailDto);
                        recentItems.put(redisEntity.getDeviceId(),dtoList);
                    }
                });
            });
        }
    return recentItems;
}

}
