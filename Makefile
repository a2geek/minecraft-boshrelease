RELEASE=minecraft-boshrelease

help:
	@echo Please specify valid target: dev, rmdev, release, final-release

dev:
	bosh create-release --force
	bosh upload-release
	bosh -n -d minecraft deploy manifest.yml \
	     -o operations/use-latest-dev.yml \
		 -o operations/set-custom-ops-json.yml \
		 -o operations/set-custom-server-properties.yml \
		 -o operations/use-custom-init-commands.yml \
		 -o operations/use-custom-modpack.yml \
		 -o operations/set-java-memory.yml \
		 -o operations/set-backup-schedule.yml \
		 -l vars.yml

rmdev:
	bosh -n -d minecraft delete-deployment

release:
	bosh create-release --force --tarball $(PWD)/$(RELEASE).tgz

final-release:
	last_tag=$$(git describe --tags --abbrev=0); \
	if grep "version: $${last_tag}" releases/$(RELEASE)/index.yml > /dev/null; \
	then \
		echo "Nothing to do."; \
	else \
		bosh create-release --final --version=$${last_tag} --tarball=$(RELEASE).tgz; \
		sha1sum $(PWD)/$(RELEASE).tgz; \
	fi