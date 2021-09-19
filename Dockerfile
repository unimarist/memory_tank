#アプリ用コンテナの素

#ベースとなるバージョン2.6.5のrubyイメージを公式リポジトリより取得
FROM ruby:2.6.5

#RUNをbashで実行
SHELL ["/bin/bash", "-c"]

#各ソフトウェア(yarn,nodejs,npm,mysql,vim,nodeバージョン管理ライブラリ)をインストール。
#イメージ軽量化のためにapt-getリストをクリア

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn nodejs npm default-mysql-client vim && \
npm install n -g && \
n 12.13.0 && \
echo "export PATH=/usr/local/n/versions/node/12.13.0/bin/:$PATH" >> ~/.bashrc && \ 
source ~/.bashrc && \ 
rm -rf /var/lib/apt/lists/*

#結合テスト(Rspec)用にChrome関連のインストール
RUN apt-get update && apt-get install -y unzip && \
    CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    chown root:root ~/chromedriver && \
    chmod 755 ~/chromedriver && \
    mv ~/chromedriver /usr/bin/chromedriver && \
    sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable

#アプリ用ディレクトリの作成 ※「memory_tank」の部分は適宜、自分のアプリ名にする
RUN mkdir /memory_tank

#ワークディレクトリを設定 ※「memory_tank」の部分は適宜、自分のアプリ名にする
WORKDIR /memory_tank

#ローカルのGemfileをアプリ用コンテナにコピーする
COPY Gemfile /memory_tank/Gemfile
COPY Gemfile.lock /memory_tank/Gemfile.lock

#アプリ用コンテナにgemをインストール
RUN gem install bundler
RUN bundle install

#ローカルのアプリファイルをまるっとアプリ用コンテナにコピー
COPY . /memory_tank