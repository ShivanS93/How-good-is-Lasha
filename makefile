.PHONY: run
run:
	@echo "Running application" && \
	docker-compose down --remove-orphans  && \
	docker-compose up --build

