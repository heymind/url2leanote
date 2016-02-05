FROM opensuse:leap

RUN \
  zypper ref && \
  zypper install  nodejs-npm git && \
  git clone https://github.com/heymind/url2leanote app && \
  cd app && \
  npm install && \
  npm install supervisor -g

WORKDIR /app

CMD ["supervisor app.js"]
