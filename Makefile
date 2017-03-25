.PHONY: all stubs build

all: stubs build

build:
	go build  ./echo
	go build main.go

stubs: echo/service.pb.go echo/service.pb.gw.go
	go generate ./echo/.

echo/service.pb.go: echo/service.proto
	protoc -I/usr/local/include -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		--go_out=,plugins=grpc:. \
		echo/service.proto

echo/service.pb.gw.go: echo/service.proto
	protoc -I/usr/local/include -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		--grpc-gateway_out=logtostderr=true:. \
		echo/service.proto
