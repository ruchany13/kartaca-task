version: '3'
services:
  prometheus:
    image: prom/prometheus:latest
    restart: always
    container_name: prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
      - ./prometheus_db:/var/lib/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    deploy:
      resources:
        limits:
          memory: 1500M
    ports:
      - '9090:9090'
    networks:
      - prometheus
    extra_hosts:
      - "nginxhost:127.0.0.1"


  cadvisor:
    image: raymondmm/cadvisor
    container_name: cadvisor
    restart: always
    deploy:
      resources:
        limits:
          memory: 1000M
    devices:
      - /dev/kmsg:/dev/kmsg
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro
    ports:
      - 8080:8080
    networks:
      - prometheus
      
  grafana:
    image: grafana/grafana
    container_name: grafana
    user: "1000"
    restart: always
    links:
      - prometheus:prometheus
    environment:
      - GF_SECURITY_ADMIN_USER=USER
      - GF_SECURITY_ADMIN_PASSWORD=PASSWORD
    volumes:
      - ./grafana_db:/var/lib/grafana
    depends_on:
      - prometheus
    ports:
      - '3000:3000'
    networks:
      - prometheus

  nodeexporter:
      image: prom/node-exporter
      container_name: node_exporter
      volumes:
        - /proc:/host/proc:ro
        - /sys:/host/sys:ro
        - /:/rootfs:ro
      command:
        - '--path.procfs=/host/proc'
        - '--path.rootfs=/rootfs'
        - '--path.sysfs=/host/sys'
        - '--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)'
      ports:
        - 9100:9100
      restart: unless-stopped
      networks:
        - prometheus

  nginx:
    image: nginx
    hostname: nginxhost
    ports:
      - "80:80"
    networks:
      - prometheus
    
networks:
  prometheus: