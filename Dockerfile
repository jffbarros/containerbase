# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

RUN apt-get update \
    && apt-get install -y pkg-config
    && apt-get install -y alien
    && apt-get install -y libaio1

RUN wget  --no-check-certificate https://googledrive.com/host/0B1Or3zIP-XLuYVhNZmthQVBTbzQ -O oracleinstantclient.rpm 
    && wget  --no-check-certificate https://googledrive.com/host/0B1Or3zIP-XLuNlJ6S2ZBZkZ6MTQ -O oraclesdk.rpm
    && alien -i oracleinstantclient.rpm
    && alien -i oraclesdk.rpm
    && cd /usr/lib/pkgconfig/ && curl -o oci8.pc https://raw.githubusercontent.com/jffbarros/testegolangdockeroracle/master/oci8.pc
    && ENV LD_LIBRARY_PATH /usr/lib:/usr/local/lib:/usr/instantclient_12_1
	&& ENV PKG_CONFIG_PATH /usr/lib/pkgconfig/oci8.pc
    && go get -u github.com/mattn/go-oci8