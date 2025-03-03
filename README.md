# Ansible - Playground

## Enable ssh on targets

To enable ssh on each target:

```bash
sudo chmod +x start_ssh.sh
./start_ssh.sh
```

or

```bash
for container in dev prod qa; do

  container_id=$(docker ps -qf "name=$container")

  if [[ -n "$container_id" ]]; then
    echo "✅ Container $container is active, starting ssh service..."
    echo "$container_id"
    docker exec "$container_id" service ssh start
  else
    echo "⚠️ Container $container is shutdown, skipping..."
  fi
done
```

#### Troubleshooting

```bash
service ssh start
```

Check if the ssh is enable:

```bash
netstat -tlnp | grep :22
```

## Connecting to the master

Run the master shell with the following command:

```bash
docker exec -it "$(docker ps -qf "name=master")" /bin/bash
```

## Ping host to quicky see if ansible is able to connect

```bash
ansible all -m ping -i inventory
```

User & passwords are defined in the `.docker/vm.dockerfile`, and configured in the `ansible/inventory`.

If you have success message, it mean you are ready to go ! 🚀

## Users configuration

| User         | Password |
| ------------ | -------- |
| root         | password |
| ansible-user | ansible  |
