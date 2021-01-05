commands to run docker
<p>
docker network create forum 
</p>
<p>
docker run --name postgres -e POSTGRES_PASSWORD=mypswd -d -p 5432:5432 -e "TZ=Europe/Warsaw" --network forum  postgres
</p>
<p>
docker run --name forum-server --rm -p 8000:8000 --network forum -v data:/var/lib/postgresql/data forum-server
</p>
