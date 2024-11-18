.PHONY: check-packer
check-packer:
	@bash -c "if ! command -v packer &> /dev/null; then echo 'ERROR: packer could not be found. Make sure it is installed and in the PATH'; exit 1; fi"

.PHONY: init
init:
	packer init .

.PHONY: check-region
check-region:
	@bash -c "if [ -z ${REGION} ]; then echo 'ERROR: REGION variable must be set. Example: \"REGION=us-east-2 make build\"'; exit 1; fi"

%.pkrvars.hcl:
	echo "Missing configuration file: ${@}."
	exit 1

.PHONY: validate
validate: check-region init
	packer validate -var "region=${REGION}" .

.PHONY: build
build: check-region init validate release.auto.pkrvars.hcl
	packer build -only="amazon-ebs.ubuntu2404" -var "region=${REGION}" .

