.PHONY: setup clean

MYSQL_ROOT_PASSWORD?=root
POSTGRES_PASSWORD?=postgres
PREFIX?=docker_

pull:
	docker-compose pull
setup:
	@if [[ -z `docker ps -a | grep $(PREFIX)data_mysql56` ]]; then \
		echo 'MySQL 5.6 data container missing.'; \
		docker run -v /var/lib/mysql -e MYSQL_ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD) --name $(PREFIX)data_mysql56 -d mysql:5.6; \
		sleep 5; \
		docker stop $(PREFIX)data_mysql56; \
	fi
	@if [[ -z `docker ps -a | grep $(PREFIX)data_mysql57` ]]; then \
		echo 'MySQL 5.7 data container missing.'; \
		docker run -v /var/lib/mysql -e MYSQL_ROOT_PASSWORD=$(MYSQL_ROOT_PASSWORD) --name $(PREFIX)data_mysql57 -d mysql:5.7; \
		sleep 5; \
		docker stop $(PREFIX)data_mysql57; \
	fi
	@if [[ -z `docker ps -a | grep $(PREFIX)data_pgsql94` ]]; then \
		echo 'PostgreSQL 9.4 data container missing.'; \
		docker run -v /var/lib/postgresql/data -e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) --name $(PREFIX)data_pgsql94 postgres:9.4 /bin/true; \
	fi
	@if [[ -z `docker ps -a | grep $(PREFIX)data_pgsql95` ]]; then \
		echo 'PostgreSQL 9.5 data container missing.'; \
		docker run -v /var/lib/postgresql/data -e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) --name $(PREFIX)data_pgsql95 postgres:9.5 /bin/true; \
	fi
	@if [[ -z `docker ps -a | grep $(PREFIX)data_elasticsearch` ]]; then \
		echo 'Elasticsearch data container missing.'; \
		docker run -v /usr/share/elasticsearch/data --name $(PREFIX)data_elasticsearch elasticsearch /bin/true; \
	fi

clean:
	docker rm -v $(PREFIX)data_mysql56 $(PREFIX)data_mysql57 $(PREFIX)data_pgsql94 $(PREFIX)data_pgsql95 $(PREFIX)data_elasticsearch
