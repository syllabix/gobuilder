# gobuilder

A simple but highly opinionated docker image used for building go apps that use protobuf, gRPC, REST APIs and PostgreSQL.

It also comes with utilities for testing and semantic versioning

### what's in the box?

please consult the dockerfile for versions of the following dependencies:

- go
- [protoc compiler](https://github.com/google/protobuf)
- [golang protobuf](github.com/golang/protobuf)
- [versioner](github.com/syllabix/versioner)
- [mockery](github.com/vektra/mockery)
- [sql migrate](github.com/rubenv/sql-migrate)
- [sqlboiler](github.com/volatiletech/sqlboiler)
