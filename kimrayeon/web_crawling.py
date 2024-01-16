from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time
from urllib.request import urlopen
import csv



# 쓰기
catagory_file = open('catagory.csv','w', encoding='utf-8',newline='')
wr = csv.writer(catagory_file)


# 읽기
barcode_file = open('barcode.csv','r')
rdr = csv.reader(barcode_file)

driver = webdriver.Chrome(service= Service(ChromeDriverManager().install()))

url = "https://www.koreannet.or.kr/front/koreannet/gtinSrch.do"
driver.get(url)

for line in rdr:
   
    # csv 파일 한줄씩 읽어서
    print(line)
    bar_code = line

     # 위치 찾고-> 지우기 -> 입력 -> 엔터
    input_box = driver.find_element(By.XPATH, '//*[@id="gtin"]') #위치 찾고
    input_box.clear() #지우기


    input_box.send_keys(bar_code) #입력
    input_box.send_keys(Keys.RETURN) # 엔터 

    time.sleep(1) # 기다렸다가
    try:
        catagory = driver.find_element(By.XPATH, '/html/body/div[2]/form/div/div/div[4]/div[2]/div[2]/div[2]/div[2]')
        wr.writerow([catagory.text])
        
   # img_url = driver.find_element(By.XPATH,'/html/body/div[2]/form/div/div/div[4]/div[1]/div/img')
    except Exception as e:
        print(f"An error occurred: {str(e)}")







    

