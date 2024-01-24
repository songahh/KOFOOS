from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import WebDriverException,NoSuchElementException, ElementNotSelectableException
from webdriver_manager.chrome import ChromeDriverManager
import time
from urllib.request import urlopen
import csv
import os
import urllib.request
import schedule
# import random


def job():
    img_folder = './img'
    user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36"
    Options = webdriver.ChromeOptions()
    Options.add_argument("user-agent="+user_agent)

    if not os.path.isdir(img_folder) : # 없으면 새로 생성하는 조건문 
        os.mkdir(img_folder)
    catagory_file = open('catagory.csv','a', encoding='utf-8',newline='')

    img_file = open('imgurl.csv','a', encoding='utf-8',newline='')

    index_write = open('index.csv','a', encoding='utf-8',newline='')
    index_read = open('index.csv','r')


    wr = csv.writer(catagory_file)
    wrImg = csv.writer(img_file)
    wr_index = csv.writer(index_write)

    # 읽기
    barcode_file = open('barcode.csv','r')
    rdr = csv.reader(barcode_file)

    index_read = open('index.csv','r')


    index = csv.reader(index_read)
    start = -1 

    for i in index:
        start = int(i[0])
        print(start)

    ### 프록시
    # 72.10.160.173 ip
    # 10677 port

    PROXY = "72.10.160.173:10677"

    webdriver.DesiredCapabilities.CHROME['proxy'] = {
    "httpProxy": PROXY,
    "ftpProxy": PROXY,
    "sslProxy": PROXY,
    "proxyType": "MANUAL"
    }

    driver = webdriver.Chrome(service= Service(ChromeDriverManager().install()),options=Options)

    url = "https://www.koreannet.or.kr/front/koreannet/gtinSrch.do"
    driver.get(url)

    cnt = 1
    for line in rdr:
        #       1~42777 현민수
        #       42778~85,554 김라연
        #       85555~128,331 권정훈
        #       128,332~171,108 권송아
        #       171,109~213,885 정현주
        #       213,886~256,666 김도형

        # 여기 바꾸시면 됩니다

        if(cnt<start):  
            cnt+=1
            continue

        if(cnt>42778):
            break

        # time.sleep( random.uniform(2,4) )
        time.sleep(1)
        # csv 파일 한줄씩 읽어서
        # print(line)
        bar_code = line[0]
            # 위치 찾고-> 지우기 -> 입력 -> 엔터

        try:
            input_box = driver.find_element(By.XPATH, '//*[@id="gtin"]') #위치 찾고
            input_box.clear() #지우기
            input_box.send_keys(bar_code) #입력
            input_box.send_keys(Keys.RETURN) # 엔터

        except NoSuchElementException as w:
            wr.writerow([""])
            wrImg.writerow("이미지 없음")
            wr   
        # 이전에 수집한 데이터를 저장하거나 다른 필요한 작업 수행
        # 크롤링 재시작을 위해 브라우저 등을 다시 초기화
            print(str(w))
            driver.quit()
            driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()),options=Options)
            driver.get(url)
            continue

        # 기다렸다가
        try:
            catagory = driver.find_element(By.XPATH, '/html/body/div[2]/form/div/div/div[4]/div[2]/div[2]/div[2]/div[2]')
            img_url = driver.find_element(By.XPATH,'/html/body/div[2]/form/div/div/div[4]/div[1]/div/img').get_attribute('src')
            urllib.request.urlretrieve(img_url, f'./img/{bar_code}.jpg')
            wr.writerow([catagory.text])
            wrImg.writerow([img_url])
            search_string="jpg"
            if search_string in img_url:
                wrImg.writerow([img_url])
            else:
                wrImg.writerow("이미지 없음")

        except NoSuchElementException as n:
            wr.writerow([""])
            wrImg.writerow("이미지 없음")
            continue   


        except Exception as e:

            print(str(e))
            continue

        print(cnt)
        cnt+=1

job()
# schedule.every(10).seconds.do(job)


# while True:
#     schedule.run_pending()
#     time.sleep(1)
