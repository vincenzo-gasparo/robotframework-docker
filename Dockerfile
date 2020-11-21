FROM python:3.8-slim-buster

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

ENV ROBOT_COMMAND="robot"
ENV ROBOT_FILES=.
ENV ROBOT_ARGS=
ENV ROBOT_ARGS_MASK=
ENV XVFB_RES=1920x1080x24

COPY bin /bin
COPY requirements.txt /tmp/requirements.txt
RUN chmod -R +x /bin
RUN python -m pip install --upgrade pip
RUN pip3 install -r /tmp/requirements.txt
RUN /bin/install_browsers.sh
WORKDIR /robot

CMD ["sh", "/bin/run.sh"]
