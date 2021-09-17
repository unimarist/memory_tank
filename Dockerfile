#アプリ用コンテナの素

#ベースとなるバージョン2.6.5のrubyイメージを公式リポジトリより取得
FROM ruby:2.6.5

#コンテナ内のパッケージ管理を最新状態にする
#前提ソフトウェア(nodejs、mysql)や保守用にvimをインストール。「--no-install-recommends」オプションを付け、recommendされた不要なソフトウェアはインストールしない
#イメージ軽量化のためにapt-getリストをクリア
RUN apt-get update && \
apt-get install -y nodejs default-mysql-client vim --no-install-recommends && \
rm -rf /var/lib/apt/lists/*

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
ADD Gemfile /memory_tank/Gemfile
ADD Gemfile.lock /memory_tank/Gemfile.lock

#アプリ用コンテナにgemをインストール
RUN gem install bundler
RUN bundle install

#ローカルのアプリファイルをまるっとアプリ用コンテナにコピー
ADD . /memory_tank