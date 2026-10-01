# ---- base: права и слои --------------------------------------------------
# FROM = берём готовый образ с Python 3.13 (debian 13 slim — лёгкий, и есть
# пакетный менеджер для системных библиотек, когда понадобятся).
FROM python:3.13-slim AS base

# ENV = переменные окружения по умолчанию (потом перекроем настоящими).
# PYTHONDONTWRITEBYTECODE — не плодить .pyc, PYTHONUNBUFFERED — логи сразу.
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# WORKDIR = рабочая папка внутри контейнера (создаётся при необходимости).
WORKDIR /app

# ---- runtime: только то, что нужно в проде ---------------------------------
FROM base AS runtime

# RUN = слои с системными зависимостями и (важно для кэша!) pip-пакетами.
# COPY идёт относительно контекста сборки — поэтому адрес app/requirements.txt.
COPY app/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# COPY = кладём код проекта в образ. .dockerignore исключает мусор.
COPY . .

# Не запускаемся от root: создаём юзера 'app', даём право на /app и
# выполняем переключение. Если контейнер взломают — получит не root.
RUN useradd -m -u 1000 app && chown -R app:app /app
USER app

# EXPOSE — документация: контейнер слушает 8000 (не открывает порт сам!
# проброс наружу делает docker run -p / compose).
EXPOSE 8000

# CMD — команда по умолчанию при запуске контейнера.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]