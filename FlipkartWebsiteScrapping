# import sys
# sys.path
# python -m pip install --upgrade pip
# pip install numpy
# pip install BeautifulSoup
# pip install requests

import pandas as pd
import requests
from bs4 import BeautifulSoup

Product_name = []
Prices = []
Description = []
Reviews = []

for i in range (2,4):
    url = "https://www.flipkart.com/search?q=samsung+mobiles&sid=tyy%2C4io&as=on&as-show=on&otracker=AS_QueryStore_OrganicAutoSuggest_1_7_na_na_ps&otracker1=AS_QueryStore_OrganicAutoSuggest_1_7_na_na_ps&as-pos=1&as-type=RECENT&suggestionId=samsung+mobiles%7CMobiles&requestId=a1fbd73d-0c19-4658-a42d-f427d748a041&as-searchtext=samsung+mobiles&page="+str(i)
    r = requests.get(url)
    # print(r)
    soup = BeautifulSoup(r.text, "lxml")
    box = soup.find("div", class_ = "DOjaWF gdgoEp")

    names = box.find_all("div", class_ = "KzDlHZ")
    # print(names)
    for i in names:
        name = i.text
        Product_name.append(name)
    # print(len(Product_name))

    price = box.find_all("div", class_ = "Nx9bqj _4b5DiR")
    for i in price:
        name = i.text
        Prices.append(name)
    # print(len(Product_name))

    desc = box.find_all("div", class_ = "_6NESgJ")
    for i in desc:
        name = i.text
        Description.append(name)
    # print(len(Description))

    review = box.find_all("div", class_ = "XQDdHH")
    for i in review:
        name = i.text
        Reviews.append(name)
    # print(len(Reviews))

df = pd.DataFrame({"Product Name": Product_name, "Prices": Prices, "Desc": Description, "Review": Reviews})
# print(df)

df.to_csv("D:/Personal Data/MyWork/Python/Samsung_Mobile_In_Flipkart_Scrapping2.csv")

# print(soup)
# while True:
# np = soup.find("a", class_ = "_9QVEpD").get("href")
# cnp = "https://www.flipkart.com"+np
# print(cnp)
# url = cnp
# r = requests.get(url)
# soup = BeautifulSoup(r.text, "lxml")


