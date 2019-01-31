# Makefile rules for development, testing, building and deployment tasks

# ENV configuration
BIN_PATH=./bin
APP_PATH=/app
APP_USER=app
CACHEBOX_PATH=/cachebox
DOCKER_MAIN_SERVICE_NAME=demo-tape-app
DOCKER_COMPOSE_FILE_DEVELOPMENT=docker-compose-development.yml
DOCKER_COMPOSE_FILE_PRODUCTION=docker-compose-production.yml




# Utilities

# Breaks output
define breakline
	@tput setaf 2
	@echo $1
	@tput sgr0
endef


# Outputs to sdout with color
# @see https://eli.thegreenplace.net/2013/12/18/makefile-functions-and-color-output
# @see https://linux.101hacks.com/ps1-examples/prompt-color-using-tput/
RED = 1
GREEN = 2
YELLOW = 3
BLUE = 4
MAGENTA = 5
CYAN = 6
define colorecho
	@tput setaf $2
	@echo $1
	@tput sgr0
endef




# Perfom a docker-compose build on specified envinronment
define docker-compose-build
	@docker-compose -f "docker-compose-$(1).yml" build
endef

# Perfom a fully docker-compose down on specified envinronment
# @see docker-compose down --help
define docker-compose-down
	@docker-compose -f "docker-compose-$(1).yml" down --rmi 'all' --volumes --remove-orphans
endef


# Login to shell on main service on specified envinronment
define docker-compose-shell
	@docker-compose -f "docker-compose-$(1).yml" exec $(DOCKER_MAIN_SERVICE_NAME) bash
endef


# Perform a docker-compose command call to main service on specified envinronment
define docker-compose-call
	@docker-compose -f "docker-compose-$(1).yml" $(2) $(DOCKER_MAIN_SERVICE_NAME) $(3)
endef


# Perfom a clean to cache on specified envinronment
define fix-perms
	@docker-compose -f "docker-compose-$(1).yml" run $(DOCKER_MAIN_SERVICE_NAME) \
		"sudo chown -R $(APP_USER):$(APP_USER) $(CACHEBOX_PATH)"
	@docker-compose -f "docker-compose-$(1).yml" run $(DOCKER_MAIN_SERVICE_NAME) \
		"sudo chown -R $(APP_USER):$(APP_USER) $(APP_PATH)"
endef


# Perfom a clean to cache on specified envinronment
define clean
	@docker-compose -f "docker-compose-$(1).yml" run $(DOCKER_MAIN_SERVICE_NAME) \
		"chown -R $(APP_USER):$(APP_USER) $(CACHEBOX_PATH)"
	@docker-compose -f "docker-compose-$(1).yml" run $(DOCKER_MAIN_SERVICE_NAME) \
		"sudo chown -R $(APP_USER):$(APP_USER) $(APP_PATH)"
	@docker-compose -f "docker-compose-$(1).yml" run $(DOCKER_MAIN_SERVICE_NAME) \
		"sudo rm -rf $(CACHEBOX_PATH)/*"
	@docker-compose -f "docker-compose-$(1).yml" run $(DOCKER_MAIN_SERVICE_NAME) \
		"sudo rm -rf node_modules/"
	@docker-compose -f "docker-compose-$(1).yml" run $(DOCKER_MAIN_SERVICE_NAME) \
		"sudo rm -rf tmp/"
endef




# Default rule
all: dev-run



# Remove local installed dependencies and modules
clean-development:
	$(call colorecho, "Removing installed dependencies and modules", $(RED))
	$(call clean,"development")
	$(call breakline, "できた (Done!)")

clean:
	$(call colorecho, "Removing installed dependencies and modules", $(RED))
	$(call clean,"production")
	$(call breakline, "できた (Done!)")


# Removes docker containers
docker-clean-development:
	$(call colorecho, "Removing docker containers", $(RED))
	$(call docker-compose-down,"development")
	$(call breakline, "できた (Done!)")

docker-clean:
	$(call colorecho, "Removing docker containers", $(RED))
	$(call docker-compose-down,"production")
	$(call breakline, "できた (Done!)")




# Local development rules

# Install app
dev-install: dev-install-base
	$(call breakline, "できた (Done!)")


# Install base dependencies
dev-install-base:
	$(call colorecho, "Installing base dependencies for development", $(YELLOW))
	$(call docker-compose-build,"development")
	$(call fix-perms,"development")
	$(call docker-compose-call,"development", "run", "$(BIN_PATH)/bundle install")
	$(call docker-compose-call,"development", "run", "$(BIN_PATH)/yarn")
	$(call breakline, "")


# Run app on local development env
dev-run: dev-install dev-run-fast

# Run app on local development env (no-check)
dev-run-fast:
	$(call colorecho, "Running app on local development mode", $(GREEN))
	docker-compose -f $(DOCKER_COMPOSE_FILE_DEVELOPMENT) up


# Enter shell shell on local development mode
dev-shell:
	$(call colorecho, "Enter shell on local development mode", $(GREEN))
	$(call docker-compose-shell,"development")




# Local production rules


# Install the server and client apps
install: install-base
	$(call breakline, "できた (Done!)")


# Install base dependencies
install-base:
	$(call colorecho, "Installing base dependencies for production", $(YELLOW))
	$(call docker-compose-build,"production")
	$(call fix-perms,"production")
	$(call docker-compose-call,"production", "run", "$(BIN_PATH)/bundle install")
	$(call docker-compose-call,"production", "run", "yarn --production")
	$(call breakline, "")


# Run app on local production env
run: install run-fast


# Run app on local production env (no-check)
run-fast:
	$(call colorecho, "Running app on local production mode", $(GREEN))
	docker-compose -f $(DOCKER_COMPOSE_FILE_PRODUCTION) up


# Enter shell shell on local production mode
shell:
	$(call colorecho, "Enter shell on local production mode", $(GREEN))
	$(call docker-compose-shell,"production")




# Test env rules

# Run tests
test: dev-install test-app
	$(call breakline, "できた (Done!)")


# Run tests for app
test-app:
	$(call colorecho, "Running tests for app", $(MAGENTA))
	$(call docker-compose-call,"development", "run", "$(BIN_PATH)/bundle exec rspec -f d")
	$(call breakline, "")






# Production env rules

# Setup production env
setup-production:
	$(BIN_PATH)/aws-setup.sh


# Build project
build:
	$(BIN_PATH)/aws-build.sh


# Deploy project
deploy:
	$(BIN_PATH)/aws-deploy.sh


# Scale up (turn on)
scale-up:
	$(BIN_PATH)/aws-scale-up.sh


# Scale down (turn off)
scale-down:
	$(BIN_PATH)/aws-scale-down.sh


# Get production environment status
status:
	$(BIN_PATH)/aws-status.sh


# Remove production env
remove-production:
	$(BIN_PATH)/aws-remove.sh





# Other rules

# Commit with Commitizen, using AngularJS's commit message
# convention (cz-conventional-changelog)
commit:
	$(call colorecho, "Making git-commit with Commitizen", $(BLUE))
	git-cz --no-verify
	# git-cz

