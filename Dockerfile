# FROM python:3.12-slim AS base

# WORKDIR /app

# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
# # Команда pip install --no-cache-dir инструктирует pip 
# # устанавливать пакеты без использования локального 
# # каталога кэша. Это означает, что вместо того, чтобы 
# # проверять и потенциально использовать ранее загруженные 
# # или построенные артефакты пакетов, pip загрузит и соберет
# # пакеты с нуля во время этой конкретной установки.
# COPY . .

# CMD ["python", "app.py"]



# Многоступенчатая сборка (Dockerfile-multistage)
# Этап 1: Установка зависимостей
FROM python:3.12-slim AS builder

WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Этап 2: Создание финального образа
FROM python:3.12-slim AS final

WORKDIR /app
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY . .

CMD ["python", "app.py"]