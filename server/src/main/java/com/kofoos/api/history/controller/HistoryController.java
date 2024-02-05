package com.kofoos.api.history.controller;

import com.kofoos.api.common.dto.HistoryDto;
import com.kofoos.api.entity.History;
import com.kofoos.api.entity.Product;
import com.kofoos.api.history.dto.HistoryProductDto;
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
        List<HistoryProductDto> productDetailDtos = historyService.HistoryDetail(requestId.getDeviceId());
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

        List<HistoryProductDto> mysql = historyService.HistoryDetail(requestId.getDeviceId());
        List<HistoryProductDto> allList = new ArrayList<>(mysql);
        Set<Object> redis = redisService.getRecentViewedItems(requestId.getDeviceId());
        if (redis != null && !redis.isEmpty()) {
            List<HistoryProductDto> redisProducts = redis.stream().map(o -> {
                RedisEntity redisEntity = (RedisEntity) o;
                return HistoryProductDto.builder()
                        .barcode(redisEntity.getBarcode())
//                        .imgurl(redisEntity.getImgUrl())
                        .itemNo(redisEntity.getDeviceId())
                        .build();
            }).collect(Collectors.toList());
            allList.addAll(redisProducts);
        }
        List<HistoryProductDto> userHistories = allList.stream()
                .distinct()
                .collect(Collectors.toList());
        // 날짜별로 정렬 확인필요
        return new ResponseEntity<>(userHistories,HttpStatus.OK);

    }

//    @Scheduled(fixedDelay = 1000)
    public void updateSql(){
        Map<String, List<HistoryProductDto>> redisHistories = redisService.getAllRedisHistories();
        for(String s:redisHistories.keySet()){
            List<HistoryProductDto> keyRedis = redisHistories.get(s);
            List<HistoryDto> histories = historyService.Histories(s);
            int cnt = Math.max(histories.size() - keyRedis.size() , 0);
            for(HistoryDto dto : histories.subList(0,10-cnt)){
                historyService.removeHistory(dto.getId());
            }

            for(HistoryProductDto dto : keyRedis.subList(0,10-cnt)){
                historyService.insert(dto);
            }



        }

        // String은 deviceId
        // redisHistories에 있는 데이터를
        // mysql로 업데이트(mysql 삭제하고 삽입 or
        // 각각의 deviceId별 redisHistories의 길이만큼만 update)
    }


}
