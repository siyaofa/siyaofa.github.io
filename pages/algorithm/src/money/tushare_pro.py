import tushare as ts
import matplotlib.pyplot as plt

token = 'bab19f5597dc1507b441e6283d24d3ab7c118833215f1821356c01ac'
ts.set_token(token)
# pro = ts.pro_api()
pro = ts.pro_api(token)
df = pro.query('trade_cal', exchange='', start_date='20180901', end_date='20181001',
               fields='exchange,cal_date,is_open,pretrade_date', is_open='0')
