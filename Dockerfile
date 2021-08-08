FROM python:3.8-slim

ARG YOUR_ENV
ENV YOUR_ENV=${YOUR_ENV} \
	PYTHONDONTWRITEBYTECODE=1\
	PYTHONUNBUFFERED=1 \
	PYTHONHASHSEED=random \
	PIP_NO_CACHE_DIR=off \
	PIP_DISABLE_PIP_VERSION_CHECK=on \
	PIP_DEFAULT_TIMEOUT=100 \
	STREAMLIT_SERVER_PORT=8998

RUN pip install pipenv
COPY Pipfile Pipfile.lock /tmp/
RUN cd /tmp && pipenv lock --requirements > requirements.txt
RUN pip install -r /tmp/requirements.txt

COPY ./.streamlit .

COPY . /usr/src/

WORKDIR /usr/src/

RUN chmod a+rx setup.sh

ENTRYPOINT [ "sh", "-c", "./setup.sh" ]
