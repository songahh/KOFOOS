package com.kofoos.api.common.dto;

import com.kofoos.api.entity.History;
import com.kofoos.api.entity.Product;
import com.kofoos.api.entity.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class HistoryDto {

    private int Id;
    private LocalDateTime viewTime;
    private String deviceId;
    private String ItemNo;

    public static HistoryDto of(History history){

        return HistoryDto.builder()
                .Id(history.getId())
                .deviceId(history.getUser().getDeviceId())
                .ItemNo(history.getProduct().getItemNo())
                .build();
    }


}
