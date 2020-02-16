FROM node:lts-slim

LABEL maintainer="Frank Niessink <frank.niessink@ictu.nl>"
LABEL description="PDF render service based on https://github.com/alvarcarto/url-to-pdf-api"

ENV NODE_ENV production

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -yq \
        wget libatk1.0-0 libasound2 fonts-lato \
        libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 \
        libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
        libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 \
        libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
        libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 \
        libxrender1 libxss1 libxtst6 libappindicator1 libnss3 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

RUN useradd --create-home renderer
WORKDIR /home/renderer
USER renderer

COPY package*.json /home/renderer/

RUN npm install 

COPY src /home/renderer/src/

CMD ["node", "/home/renderer/src/index.js"]

