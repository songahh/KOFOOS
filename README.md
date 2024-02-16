# 1.kofoos

[![kofoos.png](https://i.postimg.cc/v8zc8ff0/kofoos.png)](https://postimg.cc/jCDsZW8f)

# 2.개발 환경

Management Tool

![GitLab](https://img.shields.io/badge/GitLab-FCA121?style=for-the-badge&logo=gitlab&logoColor=white)
![JIRA](https://img.shields.io/badge/JIRA-0052CC?style=for-the-badge&logo=jira&logoColor=white)
![Mattermost](https://img.shields.io/badge/Mattermost-0072C6?style=for-the-badge&logo=mattermost&logoColor=white)
![Notion](https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white)
![Figma](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)

IDE

![IntelliJ IDEA](https://img.shields.io/badge/IntelliJ%20IDEA-000000?style=for-the-badge&logo=intellij-idea&logoColor=white)
![Android Studio](https://img.shields.io/badge/Android%20Studio-3DDC84?style=for-the-badge&logo=android-studio&logoColor=white)
![VS Code](https://img.shields.io/badge/Visual%20Studio%20Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)


Infra

![AWS](https://img.shields.io/badge/Amazon%20AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Amazon EC2](https://img.shields.io/badge/Amazon%20EC2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white)
![Amazon S3](https://img.shields.io/badge/Amazon%20S3-569A31?style=for-the-badge&logo=amazons3&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=for-the-badge&logo=jenkins&logoColor=white)


Frontend

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)


Backend

![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=spring-boot)
![Spring Data JPA](https://img.shields.io/badge/Spring%20Data%20JPA-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white)

AI

![TensorFlow Lite](https://img.shields.io/badge/TensorFlow%20Lite-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)
![YOLO](https://img.shields.io/badge/YOLO-black?style=for-the-badge&logo=appveyor)
![TorchScript](https://img.shields.io/badge/TorchScript-EE4C2C?style=for-the-badge&logo=pytorch&logoColor=white)

# 3.서비스 화면
### 회원가입 페이지
|<img src="./exec/scenario/1,2. 개인정보 동의, 재료 선택.gif">|
|------------|
| 2023-08-24 |

### 홈 화면
| <img src="./exec/scenario/3. 홈화면.gif"> | <img src="./exec/scenario/4. 에디터 추천.gif"> |
|------------|------------|
| 홈 화면  | 에디터 추천 |

### 검색 화면
| <img src="./exec/scenario/5. 검색.gif">|
|------------|
| 검색 화면 |

### 카메라 화면
| <img src="./exec/scenario/6-1. 카메라.gif"> | <img src="./exec/scenario/6-2. 카메라.gif"> |
|------------|------------|
| AI  | 바코드 |

### 위시리스트 화면
| <img src="./exec/scenario/7. 위시리스트.gif">|
|------------|
| 위시리스트 화면 |

### 마이페이지 화면
| <img src="./exec/scenario/8. 마이페이지.gif">|
|------------|
| 마이페이지 화면 |


# 4.주요 기능
- 디바이스 아이디를 통한 회원가입 절차 최소화
- 상품 실시간 스캔
- 비선호 식재료 포함된 상품 경고
- 
# 5.기술 소개

- On-Device Ai를 통한 상품 인식
  - Object Detection 딥러닝 모델 YOLO를 통해 효율적인 실시간 스캔 구현<br>
[![ondevice-AI.png](https://i.postimg.cc/L4wqB5nq/ondevice-AI.png)](https://postimg.cc/6TV5B9Vw)
<br>
- 상품 조회수를 통한 랭킹, 최근 조회한 상품
  - in-memory DB인 **Redis**의 자료구조를 이용해 정해진 기간 단위로 상품 랭킹 반영 및 사용자별 최근 본 상품 정보 제공

# 6.설계 문서
### ERD
[![ERD.png](https://i.postimg.cc/TYBrwQr4/ERD.png)](https://postimg.cc/ppY9cfcf)
### 아키텍처
[![image.png](https://i.postimg.cc/vZ9569hH/image.png)](https://postimg.cc/RWSWkW2j)
### 

## 👩‍👦‍👦👨‍👨‍👧‍👧 팀원

<table>
  <tr>
    <td>팀장</td>
    <td>팀원</td>
    <td>팀원</td>
    <td>팀원</td>
    <td>팀원</td>
  </tr>
  <tr>
    <td>권정훈</td>
    <td>권송아</td>
    <td>김도형</td>
    <td>김라연</td>
    <td>현민수</td>
  </tr>
</table>


