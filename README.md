# Packer Based Amazon ECS AMI

This is heavily based on the official [our AWS Batch AMI repo](https://github.com/cape-ph/aws-batch-ecs-ami).

## Building

- Ensure you are logged into AWS (or have credentials setup so the CLI can use
  them)
- Ensure you have packer installed (see `.tool-versions` in the repo for the
  version to use)
- build with `REGION=us-east-2 make build` (be sure to change the `REGION`
  setting as needed for your use case)
