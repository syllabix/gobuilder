FROM golang:1.16.4

RUN apt-get update && \
    apt-get -y install unzip

# install protobuf from source
# install protobuf
ENV PB_VER="3.17.0"
ENV PB_URL https://github.com/google/protobuf/releases/download/v${PB_VER}/protoc-${PB_VER}-linux-x86_64.zip
RUN mkdir -p /tmp/protoc && \
    curl -L ${PB_URL} > /tmp/protoc/protoc.zip && \
    cd /tmp/protoc && \
    unzip protoc.zip && \
    cp /tmp/protoc/bin/protoc /usr/local/bin && \
    cp -R /tmp/protoc/include/* /usr/local/include && \
    chmod go+rx /usr/local/bin/protoc && \
    cd /tmp && \
    rm -r /tmp/protoc

# Install the go protoc compiler plugin
ENV GO_PROTOC_VER="v1.5.2"
RUN go install github.com/golang/protobuf/protoc-gen-go@${GO_PROTOC_VER}

# Install go swagger
ENV GO_SWAGGER_VER="v0.27.0"
RUN go install github.com/go-swagger/go-swagger/cmd/swagger@${GO_SWAGGER_VER}

# Install versioner
ENV VERSIONER_VER="v0.7.0"
RUN go install github.com/syllabix/versioner/cmd/versioner@${VERSIONER_VER}

# Install mockery
ENV MOCKERY_VER="v2.7.5"
RUN go install github.com/vektra/mockery/v2@${MOCKERY_VER}

# Install sql-migrate
RUN go install github.com/rubenv/sql-migrate/sql-migrate@latest

# Install sql boiler
RUN go install github.com/volatiletech/sqlboiler/v4@latest
RUN go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql@latest

# Install psql
RUN apt-get install -y postgresql-client

# create cache directories
RUN mkdir -p /.cache/go-build && chmod 777 -R /.cache