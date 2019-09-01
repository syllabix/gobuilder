FROM golang:latest

# Install go swagger
ENV GO_SWAGGER_VER="v0.20.1"
RUN go get -u github.com/go-swagger/go-swagger/cmd/swagger
RUN git -C "$(go env GOPATH)"/src/github.com/go-swagger/go-swagger/cmd/swagger checkout $GO_SWAGGER_VER
RUN go install github.com/go-swagger/go-swagger/cmd/swagger

# Install versioner
ENV VERSIONER_VER="v0.5.1"
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