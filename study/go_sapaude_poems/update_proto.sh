#!/bin/sh
#protoc -I=. --go_out=. ./go_sapaude_backend_admin.proto

GoogleAPIsPATH=/private/data/projects/github.com/sapaude/protocol/third_party/googleapis

# 1. 生成 Go gRPC 代码
protoc -I. \
       -I$GoogleAPIsPATH \
       --go_out=. \
       --go_opt=paths=source_relative \
       --go-grpc_out=. \
       --go-grpc_opt=paths=source_relative \
       ./go_sapaude_backend_admin.proto

# 2. 生成 Go gRPC-Gateway 代码
protoc -I. \
       -I$GoogleAPIsPATH \
       --grpc-gateway_out=. \
       --grpc-gateway_opt=paths=source_relative \
       --grpc-gateway_opt=logtostderr=true \
       ./go_sapaude_backend_admin.proto

# 3. (可选) 生成 OpenAPI/Swagger 文档
protoc -I. \
       -I$GoogleAPIsPATH \
       --openapiv2_out=. \
       --openapiv2_opt=logtostderr=true \
       ./go_sapaude_backend_admin.proto

go mod tidy