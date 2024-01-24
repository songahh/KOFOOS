import pandas as pd
import csv

#주어진 데이터
haccp_file = open('haccppp.csv','r',encoding='utf-8')
rdr = csv.reader(haccp_file)

#매핑할 열 이름
columns = ['품목고유번호', '제품명', '원재료', '알러지', '바코드', '유형의상태', '제조사', '이미지1', '이미지2', '축산/식품구분']

# 데이터를 \ 기준으로 분할
for data in rdr:
    sample = data[0]  # 데이터가 첫 번째 열에 있다고 가정
    split_data = sample.split('\')
    try:
        # 데이터 매핑
        mapped_data = {
            '품목고유번호': split_data[0],
            '제품명': split_data[1],
            '원재료': split_data[2],
            '알러지': split_data[3],
            '바코드': split_data[4],
            '유형의상태': None,  # 유형의 상태 정보가 주어지지 않았으므로 None으로 설정
            '제조사': split_data[5],
            '이미지1': split_data[8],
            '이미지2': split_data[9],
            '축산/식품구분': split_data[10]
        }

        # 데이터프레임으로 변환
        df = pd.DataFrame([mapped_data], columns=columns)

        # 제조사 중복 제거
        df.drop_duplicates(subset='제조사', keep='first', inplace=True)
        print(df)
    except Exception as e:
        print(str(e))
# 결과 출력