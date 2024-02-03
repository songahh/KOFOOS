package com.kofoos.api.history.controller;

import com.kofoos.api.history.service.HistoryService;
import com.kofoos.api.product.dto.ProductDetailDto;
import com.kofoos.api.product.dto.RequestId;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/history")
public class HistoryController {

    private final HistoryService historyService;

    @PostMapping("/detail")
    public ResponseEntity<?> HistoryDetail(@RequestBody RequestId requestId){
        System.out.println("++++++++++++++Controller deviceId = " + requestId.getDeviceId());
        List<ProductDetailDto> productDetailDtos = historyService.HistoryDetail(requestId.getDeviceId());
        return new ResponseEntity<>(productDetailDtos, HttpStatus.OK);
    }


}
