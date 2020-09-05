# Hands-on ECR-01 : Pushing Docker Images to ECR Manually

Purpose of the this hands-on training is to give basic understanding of how to use AWS Elastic Container Registry (ECR) and how to manage docker images using ECR.

## Learning Outcomes

At the end of the this hands-on training, students will be able to;

- prepare a Docker Machine with Cloudformation.

- setup an EC2 instance with IAM role and AWS CLI for managing ECR.

- create and configure AWS ECR from the AWS Management Console.

- create and configure AWS ECR from the AWS CLI.

- demonstrate how to build a docker image with Dockerfile.

- configure AWS CLI to work with ECR

- use Docker commands effectively to tag, push, and pull images to/from ECR.

- delete images and repositories on ECR from the AWS Management Console.

- delete images and repositories on ECR from the AWS CLI.

## Outline

- Part 1 - Launching a Docker Machine Instance Configured for ECR Management

- Part 2 - Creating Repositories on AWS ECR

- Part 3 - Configuring AWS CLI to Work with AWS ECR

- Part 4 - Managing Docker Images using AWS ECR as Repository

## Part 1 - Launching a Docker Machine Instance Configured for ECR Management

- Launch a Compose enabled Docker machine on Amazon Linux 2 AMI with security group allowing HTTP and SSH connections using the [Cloudformation Template for Installing Docker Machine Configured to Work with ECR](./docker-machine-with-ecr-cfn-template.yml).

- Explain the resources in the cloudformation template and connect to your instance with SSH.

```bash

```

## Part 2 - Creating Repositories on AWS ECR

- Go to the `Amazon Elastic Container Registry` service and explain what it is.

- Introduce menus on the left side, `Amazon ECS`, `Amazon EKS`, `Amazon ECR`.

- Click on `Repositories` on ECR section, and explain the UI.

- Click on `Create Repository` and explain the default `registry` for user account. (`aws_account_id`.dkr.ecr.`region`.amazonaws.com)

- Explain repository name convention. 

- Enter a repository name ex. `callahan-repo/todo-app` (***In this hands-on, we will be working with a simple `todo list manager` that is running in `Node.js`. If you're not familiar with Node.js, don't worry! No real JavaScript experience is needed!***)

- Explain `tag immutability` and leave it as default.

- Explain `scan on push` and leave it as default.

- Create the repository and explain the complete URI.

```text

```

## Part 3 - Configuring AWS CLI to Work with AWS ECR

- Check your AWS CLI version `aws --version` command.

- Install the latest AWS CLI Version 2 if the current version is older than `1.9.15`, to use the AWS CLI with Amazon ECR. (*For this hands-on, AWS CLI Version 2 is installed by Cloudformation template*)

```bash

```

- Authenticate the Docker CLI to your default `registry` with ***"aws ecr get-login-password --region `region` | docker login --username AWS --password-stdin `aws_account_id`.dkr.ecr.`region`.amazonaws.com"***

```bash

```

## Part 4 - Managing Docker Images using AWS ECR as Repository

- Download the sample project `tar` file from the GitHub Repo on your instance. In this hands-on, we will be working with a simple `todo list manager` that is running in `Node.js`.
  
```bash

```

- Extract the `to-do-app-nodejs.tar.gz` file and change into the app directory.

```bash

```

- Download the Dockerfile within app folder.

```bash

```

- Or create a Dockerfile with following content.

```dockerfile
FROM node:12-alpine
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "/app/src/index.js"]
```

- Build the Docker container image using the `docker build` command.

```bash

```

- Show the Docker image is created successfully.

```bash

```

- Run `todo app` from the local image.

```bash

```

- List running container.

```bash

```

- Check if the To-Do App is running by entering `http://<ec2-host-name>` in a browser.

- Stop and remove container

```bash

```

- Tag the image to push it to ECR repository.

```bash

```

- Push the image to your ECR repository and show the pushed image on AWS ECR Console.

```bash

```

- Create a ECR repository named `clarusway-repo/todo-app` from AWS CLI and show it is created on AWS ECR Console.

```bash

```

- Tag and push the image to your `clarusway-repo/todo-app` repository and show the pushed image on AWS ECR Console.

```bash

```

- Delete the all local images of `todo-app`.

```bash

```

- Show that there is no image locally

```bash

```

- Pull the image from your `clarusway-repo/todo-app` repository  to the local.

```bash

```

- Or directly run the `todo-app` from the ECR repo.

```bash

```

- Check if the To-Do App is running by entering `http://<ec2-host-name>` in a browser.

- Delete Docker image on your `clarusway-repo/todo-app` ECR repository from AWS CLI.

```bash

```

- Delete the `clarusway-repo/todo-app` ECR repository from AWS CLI.

```bash

```

- Delete the image and repository of `callahan-repo/todo-app` from AWS ECR Console.
