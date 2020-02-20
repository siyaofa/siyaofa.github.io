import tushare as ts
import matplotlib.pyplot as plt


def show_stock(stock_code):
    start = '2019-01-01'
    stop = '2019-03-01'
    history = ts.get_hist_data(stock_code, start=None, end=None, ktype='W')
    # history.to_csv(stock_code + '.csv')

    plt.rcParams['font.family'] = ['sans-serif']
    plt.rcParams['font.sans-serif'] = ['SimHei']
    fig = plt.figure()

    ax = fig.add_subplot(211)
    history['close'].iloc[::-1].plot()
    ax.set_ylabel('收盘')
    ax.set_xlabel('')
    ax.set_xticks([])
    ax = fig.add_subplot(212)
    history['volume'].iloc[::-1].plot()
    ax.set_ylabel('成交量')
    ax.set_xlabel('')
    # plt.ion()


stock_codes = {'002594': '比亚迪',
               '000651': '格力'}

for code in stock_codes.keys():
    show_stock(code)

plt.show()
