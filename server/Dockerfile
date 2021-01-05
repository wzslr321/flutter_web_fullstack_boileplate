FROM golang

WORKDIR /app

RUN go get -u -v github.com/cosmtrek/air

COPY . .

EXPOSE 8000

CMD ["air", "-d"]