package org.example;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class RemoveTitle{

    public static void main(String[] args) {
        String inputFile = "haccp.csv";
        String outputFile = "haccp_remove_category.csv";
        String searchString = "prdkindstate,manufacture,rnum,prdkind,rawmtrl,prdlstNm,imgurl2,imgurl1,productGb,prdlstReportNo,allergy";

        try {
            removeRowsByString(inputFile, outputFile, searchString);
            System.out.println("Rows containing removed successfully.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void removeRowsByString(String inputFilePath, String outputFilePath, String searchString) throws IOException {
        BufferedReader reader = new BufferedReader(new FileReader(inputFilePath));
        FileWriter writer = new FileWriter(outputFilePath);

        String line;
        while ((line = reader.readLine()) != null) {
            // 만약 특정 문자열과 겹치지 않으면 쓰기
            if (!line.contains(searchString)) {
                writer.write(line + "\n");
            }
        }

        reader.close();
        writer.close();
    }
}
