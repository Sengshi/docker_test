FROM python:3.9.6-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV HOME=/app
ENV APP_HOME=/app/web
RUN mkdir $HOME
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/static
WORKDIR $APP_HOME


RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev


RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /app/web/entrypoint.sh
RUN chmod +x /app/web/entrypoint.sh

COPY . .

ENTRYPOINT ["/app/web/entrypoint.sh"]
