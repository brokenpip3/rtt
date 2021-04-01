FROM python:3.8-slim-buster
RUN useradd --create-home app
WORKDIR /usr/src/app
USER app
COPY --chown=app rtt/ .
RUN pip install -r requirements.txt --no-cache-dir --user
CMD [ "python", "/usr/src/app/rtt" ]
