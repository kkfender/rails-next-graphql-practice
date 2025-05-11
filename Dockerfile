FROM ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm && \
    npm install -g yarn

# 作業ディレクトリの設定
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# 依存関係のインストール
RUN bundle install

# アプリケーションのコードをコピー
COPY . .

# ポート3000を公開
EXPOSE 3000

# サーバー起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0"] 