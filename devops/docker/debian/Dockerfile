FROM debian:8.11

USER root
RUN mkdir -p /data
WORKDIR /data

# Téléchargement des outils necessaire
RUN echo "deb http://ftp.debian.org/debian unstable main contrib non-free" >> /etc/apt/sources.list && \
        echo "deb http://deb.debian.org/debian experimental main" >> /etc/apt/sources.list && \
        apt-get update && \
        apt-get install -y --allow-unauthenticated --fix-missing \
                openssh-server curl git wget nano && \
        curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
        apt-get install -y nodejs && curl -L https://npmjs.org/install.sh | sh && \
        rm -rf /var/lib/apt/lists/* && apt-get clean

USER debian

# Ports utilisés
EXPOSE ...

ENTRYPOINT ["..."]
CMD ["..."]