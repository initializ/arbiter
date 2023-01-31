FROM golang:1.19.4-alpine3.16
RUN mkdir -p /usr/local/bin/arbiter
WORKDIR /arbiter
COPY go.mod go.sum ./
COPY scripts scripts
RUN scripts/alpine-setup.sh
RUN go mod download
COPY cmd cmd
COPY pkg pkg
COPY Makefile Makefile
RUN make all

FROM scratch
USER 10000:10000
WORKDIR /arbiter
COPY   /app/arbiter    ./arbiter
ENTRYPOINT [ "./arbiter" ]

