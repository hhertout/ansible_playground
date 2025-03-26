docker compose down -v dev prod qa
docker compose up -d dev prod qa
docker exec -it "$(docker ps -qf "name=master")" echo "" > ~/.ssh/know_hosts
./start_ssh.sh