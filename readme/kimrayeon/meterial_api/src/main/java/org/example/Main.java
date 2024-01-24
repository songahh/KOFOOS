package org.example;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.FileWriter;
import java.io.IOException;


/*
해당 프로젝트는 maven 파일로 작성되었다.
jason을 파싱하기 위해서 mvn repo에서 com.fasterxml.jackson.core/com.fasterxml.jackson.core 두가지 의존성을 추가 했으며
barcode와 allergy가 없는 row도 있어서 예외처리를 했다.
 */

public class Main {

    static final int NUMOFROWS = 100;

    public static void main(String[] args) {
        try {
            // Open API 엔드포인트 URL
            //https://apis.data.go.kr/B553748/CertImgListServiceV2/getCertImgListServiceV2?ServiceKey=zeAC4KsPABSOkdpxyakXiGis2hMl0dni00B0jiVmmsa1KH%2FQ4UITF0gTyHKe%2FGzhXNtaDLWVR7KJ01ezqF3m4A%3D%3D&returnType=json&pageNo=1&numOfRows=100
            //String apiUrl = "http://openapi.foodsafetykorea.go.kr/api/인증키/서비스명/요청파일타입/요청시작위치/요청종료위치/변수명=값&변수명=값2";
            // String key = "zeAC4KsPABSOkdpxyakXiGis2hMl0dni00B0jiVmmsa1KH/Q4UITF0gTyHKe/GzhXNtaDLWVR7KJ01ezqF3m4A==";
            String key = "zeAC4KsPABSOkdpxyakXiGis2hMl0dni00B0jiVmmsa1KH/Q4UITF0gTyHKe/GzhXNtaDLWVR7KJ01ezqF3m4A==";
            String baseApiUrl = "https://apis.data.go.kr/B553748/CertImgListServiceV2/getCertImgListServiceV2?ServiceKey=" +
                    key + "&returnType=json&";

//1~151
            for (int pageNo = 1117; pageNo <= 1510; pageNo++) {
                String apiUrlWithIndex = baseApiUrl + "&pageNo=" + pageNo;
                System.out.println(apiUrlWithIndex);

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
                    writeAtCsv(response.toString());
                } else {
                    System.out.println("HTTP GET 요청 실패: " + responseCode);
                }

                // 연결 닫기
                connection.disconnect();

            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void writeAtCsv(String apiResponse ) {

        // Jackson ObjectMapper 생성
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // JSON 문자열을 JsonNode로 변환
            JsonNode jsonNode = objectMapper.readTree(apiResponse);

            // CSV 파일 생성 및 FileWriter 초기화
            FileWriter haccpCsvWriter = new FileWriter("haccp.csv", true);


            // CSV 파일 헤더 작성
            //haccpCsvWriter.append("prdlstReportNo\prdkindstate\manufacture,rnum,prdkind,rawmtrl,prdlstNm,imgurl2,imgurl1,productGb,prdlstReportNo,allergy");
            haccpCsvWriter.append("\n");

            // JSON 데이터에서 items 배열 가져오기
            JsonNode itemsNode = jsonNode.path("body").path("items");

            // 각 아이템을 CSV 파일에 쓰기
            for (JsonNode itemNode : itemsNode) {
                JsonNode item = itemNode.path("item");
                haccpCsvWriter.append(item.get("prdlstReportNo").asText()).append("\\"); //품목보고번호
                haccpCsvWriter.append(item.get("prdlstNm").asText()).append("\\"); //제품명
                haccpCsvWriter.append(item.get("rawmtrl").asText()).append("\\"); //원재료

                JsonNode allergyNode = item.get("allergy");

                if(allergyNode != null)
                    haccpCsvWriter.append(allergyNode.asText()).append("\\");
                else
                    haccpCsvWriter.append("").append("\\");

                JsonNode barcodeNode = item.get("barcode");
                if(barcodeNode != null)
                    haccpCsvWriter.append(barcodeNode.asText()).append("\\");
                else
                    haccpCsvWriter.append("").append("\\");

                JsonNode prdkindstateNode = item.get("prdkindstate");
                if(prdkindstateNode != null)
                    haccpCsvWriter.append(prdkindstateNode.asText()).append("\\");
                else
                    haccpCsvWriter.append("").append("\\");

                JsonNode manufactureNode = item.get("manufacture");
                if(manufactureNode != null)
                    haccpCsvWriter.append(manufactureNode.asText()).append("\\");
                else
                    haccpCsvWriter.append("").append("\\");

                haccpCsvWriter.append(item.get("manufacture").asText()).append("\\");

                JsonNode prdkindNode = item.get("prdkind");
                if(prdkindNode != null)
                    haccpCsvWriter.append(prdkindNode.asText()).append("\\");
                else
                    haccpCsvWriter.append("").append("\\");

                JsonNode imgurl2Node = item.get("imgurl2");
                if(imgurl2Node != null)
                    haccpCsvWriter.append(imgurl2Node.asText()).append("\\");
                else
                    haccpCsvWriter.append("").append("\\");

                JsonNode imgurl1Node = item.get("imgurl1");
                if(imgurl1Node != null)
                    haccpCsvWriter.append(imgurl1Node.asText()).append("\\");
                else

                    haccpCsvWriter.append("").append("\\");

                JsonNode productGbNode = item.get("productGb");
                if(productGbNode != null)
                    haccpCsvWriter.append(productGbNode.asText()).append("\\");
                else
                    haccpCsvWriter.append("").append("\\");

                haccpCsvWriter.append("\n"); //축산/식품구분
            }

            // FileWriter 닫기
            haccpCsvWriter.close();

            System.out.println("CSV 파일이 성공적으로 생성되었습니다.");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
