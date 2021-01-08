FROM golang:1.14-alpine

WORKDIR /app


RUN apk add git gcc libc-dev \
    &&  go get -u -v github.com/cosmtrek/air

COPY . .

EXPOSE 8000

CMD ["air", "-d"]