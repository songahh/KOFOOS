//package com.kofoos.api.recommendation;
//
//import com.kofoos.api.repository.ProductRepository;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
//import org.springframework.boot.test.context.SpringBootTest;
//
//
//import static org.junit.jupiter.api.Assertions.*;
//
//@SpringBootTest
//@AutoConfigureMockMvc
//public class RecommendationTest {
//
//    @Autowired
//    ProductRepository pr;
//
//    @Test
//    public void 랜덤추천결과같은결과값을가지는가(){
//
//        int[] result1 = pr.findProductsOrderByRandom(1105, 12).stream()
//                .map((entity)->entity.getId())
//                .mapToInt(Integer::intValue)
//                .toArray();
//
//        int[] result2 =  pr.findProductsOrderByRandom(1105, 12).stream()
//                .map((entity)->entity.getId())
//                .mapToInt(Integer::intValue)
//                .toArray();
//
//        assertArrayEquals(result1, result2);
//
//    }
//}
