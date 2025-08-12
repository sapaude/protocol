GoogleAPIsPATH=/private/data/projects/github.com/sapaude/protocol/third_party/googleapis
PROTO_FILE=./go_sapaude_backend_admin.proto

.PHONY: build-grpc build-grpc-gateway build-swagger build-all commit clean update

build-grpc:
	protoc -I. -I$(GoogleAPIsPATH) \
		--go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		$(PROTO_FILE)

build-grpc-gateway:
	protoc -I. -I$(GoogleAPIsPATH) \
		--grpc-gateway_out=. \
		--grpc-gateway_opt=paths=source_relative \
		--grpc-gateway_opt=logtostderr=true \
		$(PROTO_FILE)

build-swagger:
	protoc -I. -I$(GoogleAPIsPATH) \
		--openapiv2_out=. --openapiv2_opt=logtostderr=true \
		$(PROTO_FILE)

clean:
	# 根据实际生成文件路径调整
	rm -f *.pb.go
	rm -f *.swagger.json

commit:
	go mod tidy
	git add .
	git status
	git commit -am '--feat: update pb'

build-all: build-grpc build-grpc-gateway build-swagger

update: clean build-all commit