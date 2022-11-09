dc-prod = docker compose -f docker-compose-base.yml -f docker-compose-prod.yml

.PHONY: deploy
deploy:
	git pull
	$(dc-prod) build web
	$(dc-prod) run --rm web ./manage.py migrate
	$(dc-prod) up -d
