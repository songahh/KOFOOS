package com.kofoos.api.User;

import com.kofoos.api.User.dto.MyPageDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.kofoos.api.entity.User;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    //유저 등록 여부 확인 API
    @GetMapping("/check-registration/{deviceId}")
    public ResponseEntity<Boolean> checkUserRegistration(@PathVariable String deviceId) {
        boolean isRegistered = userService.isUserAlreadyRegistered(deviceId);
        return ResponseEntity.ok(isRegistered);
    }


    //유저 등록
    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody User user){
        if (userService.isUserAlreadyRegistered(user.getDeviceId())) { //이미 등록된 유저인지 확인
            return ResponseEntity.status(HttpStatus.CONFLICT).body("User already registered.");
        }
        userService.registerUser(user);
        return ResponseEntity.ok().build(); //성공하면 200
    }

    //마이페이지 조회
    @PostMapping("/mypage")
    public ResponseEntity<MyPageDto> getMyPageInfo(@RequestBody Map<String, Object> req) {
        int userId = (Integer) req.get("userId");
        System.out.println(userId);
        MyPageDto myPageInfo = userService.getMyPageInfo(userId);
        return ResponseEntity.ok(myPageInfo);
    }


    //비선호 식재료 목록 조회 API
    @GetMapping("/{userId}/dislikes")
    public ResponseEntity<List<Integer>> getUserDislikedMaterials(@PathVariable int userId) {
        List<Integer> dislikedMaterialsIds = userService.getUserDislikedMaterials(userId);
        if (dislikedMaterialsIds != null && !dislikedMaterialsIds.isEmpty()) {
            return ResponseEntity.ok(dislikedMaterialsIds);
        } else {
            return ResponseEntity.notFound().build();
        }
    }



    //회원 가입 후 비선호 음식 등록
    @PostMapping("/{userId}/dislikes")
    public ResponseEntity<?> addUserDislikedMaterials(@PathVariable int userId, @RequestBody Map<String, List<Integer>> request) {
        List<Integer> dislikedFoodsIds = request.get("dislikedFoods");
        userService.addUserDislikedMaterials(userId, dislikedFoodsIds);
        return ResponseEntity.ok().build();
    }

    // 비선호 식재료 목록 업데이트 (POST 방식)
    @PostMapping("/update")
    public ResponseEntity<?> updateUserDislikedMaterialsPost(@RequestBody Map<String, Object> request) {
        try {
            int userId = (Integer) request.get("userId");
            List<Integer> newDislikedFoodsIds = (List<Integer>) request.get("dislikedFoods");
            userService.updateUserDislikedMaterials(userId, newDislikedFoodsIds);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating disliked foods: " + e.getMessage());
        }
    }



    //회원 탈퇴
    @DeleteMapping("/{userId}")
    public ResponseEntity<?> deleteUser(@PathVariable int userId) {
        System.out.println("여긴 옴??"+userId);
        userService.deleteUser(userId);
        return ResponseEntity.ok().build();
    }


}
