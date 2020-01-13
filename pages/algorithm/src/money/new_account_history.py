# coding:utf-8
from urllib.request import urlopen
import csv

import os, re
from bs4 import BeautifulSoup

URL = "?"

http = 'http://data.eastmoney.com/cjsj/weeklystockaccounts.aspx?p=%d'


def parse_page(id, f):
    URL = http % id
    page = urlopen(URL)
    soup = BeautifulSoup(page, 'html.parser')
    tables = soup.findAll('table')
    tab = tables[0]
    # print(tab)
    for tr in tab.findAll('tr'):
        row = []
        for td in tr.findAll('td'):
            txt = td.getText().strip()
            row.append(txt)
        f.writerow(row)


#
with open('stock_account.csv', 'w', newline='') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter='\t')
    for i in range(1, 20):
        parse_page(i, spamwriter)
