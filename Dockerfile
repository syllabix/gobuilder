FROM golang:latest

RUN apt-get update && \
    apt-get -y install unzip

# install protobuf from source
# install protobuf
ENV PB_VER="3.10.0"
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
ENV GO_PROTOC_VER="v1.3.2"
RUN go get -d -u github.com/golang/protobuf/protoc-gen-go
RUN git -C "$(go env GOPATH)"/src/github.com/golang/protobuf checkout $GO_PROTOC_VER
RUN go install github.com/golang/protobuf/protoc-gen-go

# Install go swagger
ENV GO_SWAGGER_VER="v0.21.0"
RUN go get -u github.com/go-swagger/go-swagger/cmd/swagger
RUN git -C "$(go env GOPATH)"/src/github.com/go-swagger/go-swagger/cmd/swagger checkout $GO_SWAGGER_VER
RUN go install github.com/go-swagger/go-swagger/cmd/swagger

# Install versioner
ENV VERSIONER_VER="v0.7.0"
RUN go get -u github.com/syllabix/versioner/cmd/versioner
RUN git -C "$(go env GOPATH)"/src/github.com/syllabix/versioner/cmd/versioner checkout $VERSIONER_VER
RUN go install github.com/syllabix/versioner/cmd/versioner

# Install mockery
RUN go get -u github.com/vektra/mockery/cmd/mockery
RUN go install github.com/vektra/mockery/cmd/mockery

# Install sql-migrate
RUN go get -v github.com/rubenv/sql-migrate/...
RUN go install github.com/rubenv/sql-migrate

# create cache directories
RUN mkdir -p /.cache/go-build && chmod 777 -R /.cache