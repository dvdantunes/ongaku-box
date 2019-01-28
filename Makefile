# Makefile rules for development, testing, building and deployment duties

# ENV configuration
BIN_PATH=./bin
APP_USER=app
CACHEBOX_PATH=/cachebox
DOCKER_MAIN_IMAGE_NAME=website




# Utils

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



define docker-call
	@docker-compose -f "docker-compose-$(1).yml" $(2) $(DOCKER_MAIN_IMAGE_NAME) bash -c $(3)
endef




# Default rule
all: dev-run


# Remove local installed dependencies and modules
clean-development:
	$(call colorecho, "Removing installed dependencies and modules", $(RED))
	$(call docker-call,"development", "run", "sudo chown -R $(APP_USER):$(APP_USER) $(CACHEBOX_PATH) && rm -rf $(CACHEBOX_PATH)/* && rm -rf node_modules/")
	$(call breakline, "できた (Done!)")

clean-production:
	$(call colorecho, "Removing installed dependencies and modules", $(RED))
	$(call docker-call,"production", "run", "sudo chown -R $(APP_USER):$(APP_USER) $(CACHEBOX_PATH) && rm -rf $(CACHEBOX_PATH)/* && rm -rf node_modules/")
	$(call breakline, "できた (Done!)")



#
docker-compose-development:
	docker-compose -f docker-compose-development.yml up


docker-compose-production:
	docker-compose -f docker-compose-production.yml up



# Local development rules

# Install app
dev-install: dev-install-base
	$(call breakline, "できた (Done!)")


# Install base dependencies
dev-install-base:
	$(call colorecho, "Installing base dependencies for development", $(YELLOW))
	$(call docker-call,"development", "run", "bin/bundle install; yarn")
	$(call breakline, "")


# Run app on local development env
dev-run: dev-install dev-run-fast

# Run app on local development env (no-check)
dev-run-fast:
	$(call colorecho, "Running app on local development mode", $(GREEN))
	docker-compose-development





# Local production rules


# Install the server and client apps
install: install-base
	$(call breakline, "できた (Done!)")


# Install base dependencies
install-base:
	$(call colorecho, "Installing base dependencies for production", $(YELLOW))
	$(call docker-call,"production", "run", "bin/bundle install")
	$(call docker-call,"production", "run", "yarn --production")
	$(call breakline, "")


# Run app on local production env
run: install run-fast


# Run app on local production env (no-check)
run-fast:
	$(call colorecho, "Running app on local production mode", $(GREEN))
	docker-compose-production





# Test env rules

# Run tests
test: dev-install test-app
	$(call breakline, "できた (Done!)")


# Run tests for app
test-app:
	$(call colorecho, "Running tests for app", $(MAGENTA))
	$(call docker-call,"development", "run", "bin/bundle exec rspec -f d")
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


# Get production env status
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

