FROM python:3.9-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    adduser --disabled-password --gecos "" parsedmarc && \
    pip install --root-user-action=ignore -U pip && \
    pip install --root-user-action=ignore parsedmarc msgraph-core==0.2.2 && \
    mkdir -p /parsedmarc && \
    chown -R parsedmarc:parsedmarc /parsedmarc

ENV REPORTS_FOLDER=INBOX \
    ARCHIVE_FOLDER=Archive

USER parsedmarc
CMD ["bash", "/start.sh"]