.PHONY: help run stop rebuild test

.DEFAULT: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36mmake %-20s\033[0m\n\t%s\n", $$1, $$2}'

run: stop  ## starts the application
	docker-compose up -d
	@echo "Strapi running on http://localhost:1337"

run-logs: stop  ## starts the application with logs
	docker-compose up -d && docker-compose logs -f -t
	@echo "Strapi running on http://localhost:1337"

stop:  ## stops the application
	docker-compose down
	@echo "Stopped the application."

rebuild: stop  ## rebuild and start the application
	docker-compose up -d --build
