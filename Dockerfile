FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code

# install pip-tools and pip
# hadolint ignore=DL3013
RUN pip install --no-cache-dir -U pip-tools pip
COPY requirements.in .

# install python dependences
# hadolint ignore=DL3042
RUN pip-compile -o requirements.txt requirements.in && \
  pip install --no-cache-dir --no-deps -r requirements.txt

COPY . .
ENTRYPOINT ["sh", "-c", "/code/docker-entrypoint.sh"]
