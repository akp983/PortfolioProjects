# import numpy

from bs4 import BeautifulSoup
import requests
import pandas as pd

url = "https://www.imdb.com/chart/top/"
HEADERS = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'}
page = requests.get(url, headers=HEADERS)
soup = BeautifulSoup(page.content, "html.parser")
# print(soup.prettify())

box = soup.find("ul", class_="ipc-metadata-list ipc-metadata-list--dividers-between sc-a1e81754-0 eBRbsI compact-list-view ipc-metadata-list--base")
scraped_movies = box.find_all("h3", class_="ipc-title__text")
# print(scraped_movies)

movies = []
for movie in scraped_movies:
    movie = movie.get_text().replace('\n', "")
    movie = movie.strip(" ")
    movies.append(movie)
# print(movies)

scraped_ratings = box.find_all("span", class_="ipc-rating-star--rating")
# print(scraped_ratings)
ratings = []
for rating in scraped_ratings:
    rating = rating.get_text().replace('\n', "")
    rating = rating.strip(" ")
    ratings.append(rating)
# print(ratings)

scraped_vote_count = box.find_all("span", class_="ipc-rating-star--voteCount")

vote_counts = []
for vote in scraped_vote_count:
    vote = vote.get_text().replace("\xa0", "")
    vote = vote.strip(" ")
    vote_counts.append(vote)
# print(vote_counts)

# sc-b189961a-7 feoqjK cli-title-metadata
# scraped_year = box.find_all("span", class_="sc-b189961a-8 kLaxqf cli-title-metadata-item")
#
# movie_year = []
# for year in scraped_year:
#     year = year.get_text()
#     # year = year.strip(" ")
#     movie_year.append(year)
# # print(movie_year[:])

data = pd.DataFrame()

data['Movie Names'] = movies
data['Ratings'] = ratings
data['Vote Count'] = vote_counts
# data['Years_Duration_Certificate'] = movie_year

# print(data.head())
data.to_csv('D:/Personal Data/MyWork/Python/IMDB Top Movies.csv', index=False)
