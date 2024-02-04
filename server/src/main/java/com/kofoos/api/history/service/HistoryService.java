package com.kofoos.api.history.service;

import com.kofoos.api.history.dto.HistoryProductDto;
import com.kofoos.api.history.repository.HistoryRepository;
import com.kofoos.api.product.dto.ProductDetailDto;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class HistoryService {

    private final HistoryRepository historyRepository;


    public List<HistoryProductDto> HistoryDetail(String deviceId){

        System.out.println("++++++++++++++Service deviceId = " + deviceId);
        System.out.println(" historyRepository.HistoryDetail(deviceId) = " +  historyRepository.HistoryDetail(deviceId));
        List<HistoryProductDto> dtoList =
        historyRepository.HistoryDetail(deviceId).stream()
                .map(history -> HistoryProductDto.of(history))
                .collect(Collectors.toList());
        return dtoList;

    }







}
