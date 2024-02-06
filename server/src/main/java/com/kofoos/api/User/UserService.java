package com.kofoos.api.User;

import com.kofoos.api.User.Repository.HistoryRepository;
import com.kofoos.api.User.Repository.UserDislikesMaterialRepository;
import com.kofoos.api.common.dto.HistoryDto;
import com.kofoos.api.User.dto.MyPageDto;
import com.kofoos.api.entity.DislikedMaterial;
import com.kofoos.api.entity.User;
import com.kofoos.api.entity.UserDislikesMaterial;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import com.kofoos.api.User.Repository.DislikedMaterialRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final UserDislikesMaterialRepository userDislikesMaterialsRepo;
    private final DislikedMaterialRepository dislikedMaterialRepository;
    private final HistoryRepository historyRepository;

    public void registerUser(User user){
        userRepository.save(user);
    }

    //유저 가입여부 확인용 메서드
    public boolean isUserAlreadyRegistered(String deviceId) {
        return userRepository.existsByDeviceId(deviceId);
    }

    //비선호 음식 추가
    public void addUserDislikedMaterials(int userId, List<Integer> materialIds) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        for (Integer materialId : materialIds) {
            DislikedMaterial material = dislikedMaterialRepository.findById(materialId)
                    .orElseThrow(() -> new RuntimeException("Disliked Material not found"));

            UserDislikesMaterial userDislikesMaterials = UserDislikesMaterial.builder()
                    .user(user)
                    .dislikedMaterial(material)
                    .build();
            userDislikesMaterialsRepo.save(userDislikesMaterials);
        }
    }

    // 사용자 ID를 기반으로 비선호 식재료 ID 목록 조회
    public List<Integer> getUserDislikedMaterials(int userId) {
        return userDislikesMaterialsRepo.findByUserId(userId)
                .stream()
                .map(UserDislikesMaterial::getMaterialId) // getMaterialId()는 실제 식재료 ID를 반환하는 메소드 이름으로 가정
                .collect(Collectors.toList());
    }

    // 사용자의 비선호 식재료 목록을 새 목록으로 업데이트
    @Transactional
    public void updateUserDislikedMaterials(int userId, List<Integer> newDislikedMaterialsIds) {
        // 사용자 객체 조회
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        // 기존 비선호 식재료 목록 삭제
        userDislikesMaterialsRepo.deleteByUserId(userId);

        // 새로운 비선호 식재료 목록 삽입
        for (Integer materialId : newDislikedMaterialsIds) {
            DislikedMaterial material = dislikedMaterialRepository.findById(materialId)
                    .orElseThrow(() -> new RuntimeException("Disliked Material not found"));

            UserDislikesMaterial newUserDislikesMaterial = UserDislikesMaterial.builder()
                    .user(user)
                    .dislikedMaterial(material)
                    .build();
            userDislikesMaterialsRepo.save(newUserDislikesMaterial);
        }
    }



    //회원 삭제
    public void deleteUser(int userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        userRepository.delete(user);
    }

    //마이페이지 조회
    public MyPageDto getMyPageInfo(int userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        String language = user.getLanguage();
        System.out.println("언어정보:"+language);

        // 비선호 식재료 ID 목록 조회
        List<Integer> dislikedMaterials = userDislikesMaterialsRepo.findByUserId(userId).stream()
                .map(udm -> udm.getDislikedMaterial().getId()) // material_id를 직접 사용
                .collect(Collectors.toList());

        // 히스토리 변환 (최근 10개, 중복 제거)
        List<HistoryDto> histories = historyRepository.findTop10ByUserIdOrderByViewTimeDesc(userId).stream()
                .distinct()
                .map(history -> HistoryDto.of(history))
                .collect(Collectors.toList());

        List<String> products = histories.stream()
                .map(historyDto -> historyDto.getProductUrl())
                .collect(Collectors.toList());

        return new MyPageDto(language, dislikedMaterials, products);
    }


}
