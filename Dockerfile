FROM python:3.11-slim

# 安装依赖和 Alloy 的下载工具
RUN apt-get update && apt-get install -y curl gcc \
    && curl -fsSL https://github.com/grafana/alloy/releases/download/v1.0.0/alloy-linux-amd64.zip -o alloy.zip \
    && apt-get install -y unzip \
    && unzip alloy.zip && mv alloy-linux-amd64 /usr/local/bin/alloy \
    && chmod +x /usr/local/bin/alloy \
    && rm -rf alloy.zip /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt main.py healthcheck.py prometheus_metrics.py config.alloy /app/
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

# 用一段内联 shell 同时跑 Python 程序和 Alloy
CMD /usr/local/bin/alloy run --server.http.listen-addr=127.0.0.1:12345 /app/config.alloy & python main.py
