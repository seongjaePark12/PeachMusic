import requests
from bs4 import BeautifulSoup as bs
from selenium import webdriver
import time
from pytube import YouTube
import os
import re

# 차트 수집
url = 'https://music.bugs.co.kr/chart'
data = requests.get(url)
soup = bs(data.text, 'html.parser')

titles = soup.select('p.title')
artists = soup.select('p.artist')
imgs = soup.select('.list>tbody>tr')

title_list = []
artist_list = []
img_list = []

for i in range(100):
    title_list.append(titles[i].text.strip())
    artist_list.append(artists[i].select('a')[0].text)
    img_list.append(imgs[i].select('a>img')[0].get('src'))


# 음원 다운로드
    # url 수집
yt_url_list = []

driver = webdriver.Chrome('./95/chromedriver.exe')

for i in range(100):
    keyword = '{} {} official audio, short'.format(
        title_list[i], artist_list[i])
    url = 'https://www.youtube.com/results?search_query=' + keyword

    driver.get(url)
    soup = bs(driver.page_source, 'html.parser')
    html = soup.select('a#video-title')[0]
    video_url = 'https://www.youtube.com' + html.get('href')
    yt_url_list.append(video_url)
driver.close()

# 음원 파일 수집
for i in range(100):
    keyword = '{} - {}'.format(title_list[i], artist_list[i])
    keyword = re.sub('[\\\/:*?\"<>|]', '', keyword)

    # if os.path.exists('..\\music_db\\' + keyword + '.mp3'):
    if os.path.exists('D:\javaCourse\SpringFrameWork\works\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\PSJMusic\resources\music\\' + keyword + '.mp3'):
        print(keyword + ' is already exist')
        pass
    else:
        yt = YouTube(yt_url_list[i])
        audio = yt.streams.get_by_itag(140)
        # audio.download('..\\music_db', keyword + '.mp3')
        audio.download(
            'D:\javaCourse\SpringFrameWork\works\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\PSJMusic\resources\music', keyword + '.mp3')
        
        print(keyword + ' is downloaded')
        time.sleep(2)
