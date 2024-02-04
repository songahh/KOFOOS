package com.kofoos.api.history.controller;

import com.kofoos.api.entity.Product;
import com.kofoos.api.history.service.HistoryService;
import com.kofoos.api.product.dto.ProductDetailDto;
import com.kofoos.api.product.dto.RequestId;
import com.kofoos.api.redis.RedisEntity;
import com.kofoos.api.redis.RedisService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/history")
public class HistoryController {

    private final HistoryService historyService;
    private final RedisService redisService;

    @PostMapping("/sql")
    public ResponseEntity<?> getHistoriesSql(@RequestBody RequestId requestId){
        System.out.println("++++++++++++++Controller deviceId = " + requestId.getDeviceId());
        List<ProductDetailDto> productDetailDtos = historyService.HistoryDetail(requestId.getDeviceId());
        return new ResponseEntity<>(productDetailDtos, HttpStatus.OK);
    }

    @PostMapping("/redis")
    public ResponseEntity<?> getHistoriesRedis(@RequestBody RequestId requestId){
        System.out.println("deviceId = " + requestId.getDeviceId());
        Set<Object> histories = redisService.getRecentViewedItems(requestId.getDeviceId());
        return new ResponseEntity<>(histories,HttpStatus.OK);

    }

    @PostMapping("/all")
    public ResponseEntity<?> getHistories(@RequestBody RequestId requestId){
        int count = 10;
        List<ProductDetailDto> mysql = historyService.HistoryDetail(requestId.getDeviceId());
        List<ProductDetailDto> allList = new ArrayList<>(mysql);
        Set<Object> redis = redisService.getRecentViewedItems(requestId.getDeviceId());
        if (redis != null && !redis.isEmpty()) {
            List<ProductDetailDto> redisProducts = redis.stream().map(o -> {
                RedisEntity redisEntity = (RedisEntity) o;
                return ProductDetailDto.builder()
                        .barcode(redisEntity.getBarcode())
                        .imgurl(redisEntity.getImgUrl())
                        .itemNo(redisEntity.getDeviceId())
                        .build();
            }).collect(Collectors.toList());
            allList.addAll(redisProducts);
        }
        List<ProductDetailDto> userHistories = allList.stream()
                .distinct()
                .collect(Collectors.toList());

        return new ResponseEntity<>(userHistories,HttpStatus.OK);

    }

    @Scheduled(fixedDelay = 1000)
    public void updateSql(){
        Map<String,ProductDetailDto> redisHistories = redisService.getAllRedisHistories();
        // redisHistories에 있는 데이터를
        // mysql로 업데이트(mysql 삭제하고 삽입 or
        // 각각의 deviceId별 redisHistories의 길이만큼만 update)
    }


}
