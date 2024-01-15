import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class Main {

    static final int THOUSAND = 1000;

    public static void main(String[] args) {
        try {
            // Open API 엔드포인트 URL
            //String apiUrl = "http://openapi.foodsafetykorea.go.kr/api/인증키/서비스명/요청파일타입/요청시작위치/요청종료위치/변수명=값&변수명=값2";
            String key = "인증키";
            String baseApiUrl  = "https://openapi.foodsafetykorea.go.kr/api/7984bc9ec0834b3997bf/I1250/json";
            int start = 1;
            int end = 1000;

            while(end<939790) {
                String apiUrlWithIndex  = baseApiUrl + "/" + Integer.toString(start) + "/" + Integer.toString(end);
                URL url = new URL(apiUrlWithIndex);
                // HttpURLConnection 객체 생성
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();

                // HTTP GET 메소드 설정
                connection.setRequestMethod("GET");

                // 응답 코드 확인
                int responseCode = connection.getResponseCode();

                if (responseCode == HttpURLConnection.HTTP_OK) {
                    // 응답을 읽어오기 위한 BufferedReader 생성
                    BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                    String inputLine;
                    StringBuilder response = new StringBuilder();

                    // 응답 내용을 읽어 StringBuilder에 저장
                    while ((inputLine = in.readLine()) != null) {
                        response.append(inputLine);
                    }
                    in.close();

                    // 응답 내용 출력
                    System.out.println("API 응답 내용: " + response.toString());
                } else {
                    System.out.println("HTTP GET 요청 실패: " + responseCode);
                }

                // 연결 닫기
                connection.disconnect();


                System.out.println(url);

                start += THOUSAND;
                end += THOUSAND;
            }




        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
