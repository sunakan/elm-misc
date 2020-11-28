include makefiles/gitignore.mk
include makefiles/rq.mk
include makefiles/help.mk

################################################################################
# 変数
################################################################################

################################################################################
# マクロ
################################################################################

################################################################################
# タスク
################################################################################
.PHONY: up
up:
	docker-compose up

.PHONY: down
down:
	docker-compose down

.PHONY: chown
chown:
	sudo chown $(shell id -u):$(shell id -g) -R ./app/

.PHONY: build-for-deploy
build-for-deploy:
	mkdir -p dist
	cd app && elm make ./src/Main.elm --debug --output=../dist/index.html

.PHONY: build-docker
build-docker:
	docker build ./ --tag sunakan/elm:0.19.1

.PHONY: push-docker
push-docker:
	docker push sunakan/elm:0.19.1

.PHONY: bash
bash:
	docker-compose run --rm elm bash
