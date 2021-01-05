FROM golang

WORKDIR /app

COPY . ./

RUN go get

EXPOSE 8000

CMD ["go", "run", "main.go"]