FROM maven:3.5-alpine

# Make app directory
RUN mkdir -p /usr/src/app

# Set app directory as working directory
WORKDIR /usr/src/app

ARG SHOWVOC_VERSION=2.4.0

# Download VocBench, unzip, remove
RUN wget https://bitbucket.org/art-uniroma2/showvoc/downloads/showvoc-${SHOWVOC_VERSION}-full.zip && \
    unzip ./showvoc-${SHOWVOC_VERSION}-full.zip && \
    rm ./showvoc-${SHOWVOC_VERSION}-full.zip && \
    mv semanticturkey-* semanticturkey

# Fix executable file permission
RUN chmod +x /usr/src/app/semanticturkey/bin/karaf

# Set container entrypoint on Karaf container script
ENTRYPOINT [ "/usr/src/app/semanticturkey/bin/karaf", "server" ]

# Expose port 1979 (where ST runs by default)
EXPOSE 1979