import requests
from bs4 import BeautifulSoup as bs
import json

data = requests.get('https://music.bugs.co.kr/chart/track/day/total')
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

song_dict = {'songs': []}

for i in range(100):
    song_dict['songs'].append(
        {'img': img_list[i], 'title': title_list[i], 'artist': artist_list[i]})

# song_json = json.dumps(song_dict)

with open("song_json.json", "w") as f:
    json.dump(song_dict, f)