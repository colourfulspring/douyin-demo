FROM mysql:8.0.34-debian
RUN  apt-get -y update && apt-get -y upgrade \
&& apt-get -y install wget && wget -O go.tar.gz "https://go.dev/dl/go1.21.0.linux-amd64.tar.gz" \
&& tar -xvf go.tar.gz && rm -rf /usr/local/go \
&& mv ./go /usr/local && rm go.tar.gz
ENV PATH="$PATH:/usr/local/go/bin"
EXPOSE 8080