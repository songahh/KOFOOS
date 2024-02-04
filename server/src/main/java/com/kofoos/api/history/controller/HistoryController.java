package com.kofoos.api.history.controller;

import com.kofoos.api.history.service.HistoryService;
import com.kofoos.api.product.dto.ProductDetailDto;
import com.kofoos.api.product.dto.RequestId;
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

import java.util.List;
import java.util.Set;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/history")
public class HistoryController {

    private final HistoryService historyService;
    private final RedisService redisService;

    @PostMapping("/detail/sql")
    public ResponseEntity<?> HistoryDetail(@RequestBody RequestId requestId){
        System.out.println("++++++++++++++Controller deviceId = " + requestId.getDeviceId());
        List<ProductDetailDto> productDetailDtos = historyService.HistoryDetail(requestId.getDeviceId());
        return new ResponseEntity<>(productDetailDtos, HttpStatus.OK);
    }

    @PostMapping("/detail/redis")
    public ResponseEntity<?> getHistories(@RequestBody RequestId requestId){
//        deviceId = deviceId.replace("\"","");
        System.out.println("deviceId = " + requestId.getDeviceId());
        Set<Object> histories = redisService.getRecentViewedItems(requestId.getDeviceId());
        return new ResponseEntity<>(histories,HttpStatus.OK);

    }


    @Scheduled(fixedDelay = 1000)
    public void updateSqlHistory(){
//        System.out.println("Hello Hello");
        //레디스에서 가져와서 갱신을 해야하나?
        //모든 유저를 가져와야 하나?

    }

}
