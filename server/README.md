commands to run docker
docker network create forum
docker run --name postgres -e POSTGRES_PASSWORD=mypswd -d -p 5432:5432 -e "TZ=Europe/Warsaw" --network forum -v data:/var/lib/postgresql/data  postgres
docker run --name forum-server --rm -p 8000:8000 --network forum -v /home/wiktor/Development/Projects/todo_website/server:/app -v logs:/app/logs  forum-server
