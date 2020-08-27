FROM python:3.8-slim-buster

ENV CHROMEVERSION=google-chrome-stable
ENV TESTDIR=
ENV THREADS=0
ENV ROBOTARGS=
ENV SUBTESTDIR=
ENV XVFB_RES=1920x1080x24

COPY bin /bin
COPY requirements.txt /tmp/requirements.txt
RUN chmod -R +x /bin
RUN python -m pip install --upgrade pip
RUN pip3 install -r /tmp/requirements.txt
RUN /bin/install_browsers.sh

CMD ["/bin/run.sh"]
