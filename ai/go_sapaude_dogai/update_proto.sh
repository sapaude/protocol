#!/bin/sh

# 全局配置
PACKAGE_NAME="go_sapaude_dogai"
GoogleAPIsPATH=/private/data/projects/github.com/sapaude/protocol/third_party/googleapis

# 1. 编译消息定义文件 (排除主服务文件)
for proto in *.proto; do
    [ "$proto" != "${PACKAGE_NAME}.proto" ] && [ -f "$proto" ] && \
        protoc -I. -I$GoogleAPIsPATH \
            --go_out=. --go_opt=paths=source_relative \
            ./$proto
done

# 2. 编译主服务文件 (gRPC + Gateway + OpenAPI)
echo "Compile grpc..."
protoc -I. -I$GoogleAPIsPATH \
       --go_out=. --go_opt=paths=source_relative \
       --go-grpc_out=. --go-grpc_opt=paths=source_relative \
       ./${PACKAGE_NAME}.proto

echo "Compile grpc-gateway..."
protoc -I. -I$GoogleAPIsPATH \
       --grpc-gateway_out=. --grpc-gateway_opt=paths=source_relative \
       --grpc-gateway_opt=logtostderr=true \
       ./${PACKAGE_NAME}.proto

echo "Compile swagger api doc..."
protoc -I. -I$GoogleAPIsPATH \
       --openapiv2_out=. --openapiv2_opt=logtostderr=true \
       ./${PACKAGE_NAME}.proto

# 3. 整理依赖
go mod tidy

# 4. git commit
echo "git commit & push..."
git commit -am '--feat: update protobuf'
git push