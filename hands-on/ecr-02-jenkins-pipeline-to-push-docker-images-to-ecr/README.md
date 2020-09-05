# Hands-on ECR-02 : Jenkins Pipeline to Push Docker Images to ECR

Purpose of the this hands-on training is to teach the students how to build Jenkins pipeline to create Docker image and push the image to AWS Elastic Container Registry (ECR) on Amazon Linux 2 EC2 instance.

## Learning Outcomes

At the end of the this hands-on training, students will be able to;

- create and configure AWS ECR from the AWS Management Console.

- configure Jenkins Server with Git, Docker, AWS CLI on Amazon Linux 2 EC2 instance using Cloudformation Service.

- demonstrate how to build a docker image with Dockerfile.

- configure AWS CLI to work with ECR.

- build Jenkins pipelines with Jenkinsfile.

- integrate Jenkins pipelines with GitHub using Webhook.

- configure Jenkins Pipeline to build a NodeJS project.

- use Docker commands effectively to tag, push, and pull images to/from ECR.

- create repositories on ECR from the AWS Management Console.

- delete images and repositories on ECR from the AWS CLI.

## Outline

- Part 1 - Launching a Jenkins Server Configured for ECR Management

- Part 2 - Prepare the Image Repository on ECR and Project Repository on GitHub with Webhook

- Part 3 - Creating Jenkins Pipeline for the Project with GitHub Webhook

- Part 4 - Cleaning up the Image Repository on AWS ECR

## Part 1 - Launching a Jenkins Server Configured for ECR Management

- Launch a pre-configured `Clarusway Jenkins Server` from the AMI of Clarusway (ami-08857fc3e51ff205e) running on Amazon Linux 2, allowing SSH (port 22) and HTTP (ports 80, 8080) connections using the [Clarusway Jenkins Server on Docker Cloudformation Template Configured to Work with ECR](./clarusway-jenkins-with-git-docker-ecr-cfn.yml). Clarusway Jenkins Server is configured with admin user `call-jenkins` and password `Call-jenkins1234`.

- Or launch and configure a Jenkins Server on Amazon Linux 2 AMI with security group allowing SSH (port 22) and HTTP (ports 80, 8080) connections using the [Cloudformation Template for Jenkins on Docker Installation](./jenkins-with-git-docker-ecr-cfn.yml).

  - Connect to your instance with SSH.

    ```bash
   
    ```

  - Get the administrator password from `/var/lib/jenkins/secrets/initialAdminPassword` file.

    ```bash
    
    ```

  - Enter the temporary password to unlock the Jenkins.

  - Install suggested plugins.

  - Create first admin user (`call-jenkins:Call-jenkins1234`).

  - Check the URL, then save and finish the installation.

  - Open your Jenkins dashboard and navigate to `Manage Jenkins` >> `Manage Plugins` >> `Available` tab

  - Search and select `GitHub Integration` plugin, then click to `Install without restart`. Note: No need to install the other `Git plugin` which is already installed can be seen under `Installed` tab.

## Part 2 - Prepare the Image Repository on ECR and Project Repository on GitHub with Webhook

- Create a docker image repository `clarusway-repo/todo-app` on AWS ECR from Management Console.

- Create a public project repository `todo-app-node-project` on your GitHub account.

- Clone the `todo-app-node-project` repository on local computer.

- Download the sample project [To Do App](./to-do-app-nodejs.tar.gz) gzip file from the `Clarusway` GitHub Repo on your local. In this hands-on, we will be working with a simple `todo list manager` running in `Node.js`.

- Extract the `to-do-app-nodejs.tar.gz` file into your local repository.

```bash

```

- Add `.gitignore` file to exclude `to-do-app-nodejs.tar.gz` file from Git repo.

- Create a Dockerfile with following content within your `todo-app-node-project` repository.

```dockerfile
FROM node:12-alpine
WORKDIR /app
COPY ./to-do-app-nodejs .
RUN yarn install --production
CMD ["node", "/app/src/index.js"]
```

- Commit and push the local changes to update the remote repo on GitHub.

```bash

```

- Go to the `todo-app-node-project` repository page and click on `Settings`.

- Click on the `Webhooks` on the left hand menu, and then click on `Add webhook`.

- Copy the Jenkins URL from the AWS Management Console, paste it into `Payload URL` field, add `/github-webhook/` at the end of URL, and click on `Add webhook`.

```text

```

## Part 3 - Creating Jenkins Pipeline for the Project with GitHub Webhook

- Go to the Jenkins dashboard and click on `New Item` to create a pipeline.

- Enter `todo-app-pipeline` then select `Pipeline` and click `OK`.

- Enter `To Do App pipeline configured with Jenkinsfile and GitHub Webhook` in the description field.

- Put a checkmark on `GitHub Project` under `General` section, enter URL of the project repository.

```text

```

- Put a checkmark on `GitHub hook trigger for GITScm polling` under `Build Triggers` section.

- Go to the `Pipeline` section, and select `Pipeline script from SCM` in the `Definition` field.

- Select `Git` in the `SCM` field.

- Enter URL of the project repository, and let others be default.

```text

```

- Click `apply` and `save`. Note that the script `Jenkinsfile` should be placed under root folder of repo.

- Create a `Jenkinsfile` within the `todo-app-node-project` repo with following pipeline script.

```groovy
pipeline {
    agent { label "master" }
    environment {
        ECR_REGISTRY = "<aws-account-id>.dkr.ecr.us-east-1.amazonaws.com"
        APP_REPO_NAME= "clarusway-repo/todo-app"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build --force-rm -t "$ECR_REGISTRY/$APP_REPO_NAME:latest" .'
                sh 'docker image ls'
            }
        }
        stage('Push Image to ECR Repo') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$ECR_REGISTRY"'
                sh 'docker push "$ECR_REGISTRY/$APP_REPO_NAME:latest"'
            }
        }
    }
    post {
        always {
            echo 'Deleting all local images'
            sh 'docker image prune -af'
        }
    }
}
```

- Commit and push the local changes to update the remote repo on GitHub.

```bash

```

- Go to the Jenkins project page and click `Build Now`.The job has to be executed manually one time in order for the push trigger and the git repo to be registered.

- Observe the manual built, explain the built results, and show the output from the shell.

- Connect to Jenkins Server instance with SSH.

- Show that there is no image locally on the server.

```bash
docker image ls
```

- Authenticate the Docker CLI to your default `ECR registry`.

```bash

```

- Pull the image from your `clarusway-repo/todo-app` repository  to the local.

```bash

```

- Run the `todo-app`.

```bash

```

- Check if the To-Do App is running by entering `http://<ec2-host-name>` in a browser. Show that the application has `No items yet! Add one above!` when there is no todo item. We will change this text.

- Stop and remove container

```bash

```

- Delete the all local images of `todo-app`.

```bash

```

- Now, to trigger an automated build on Jenkins Server, we need to change code in the repo. For example, in the `src/static/js/app.js` file, update line 56 of `<p className="text-center">No items yet! Add one above!</p>` with following new text.

```html
 <p className="text-center">You have no todo task yet! Go ahead and add one!</p>
```

- Commit and push the change to the remote repo on GitHub.

```bash

```

- Observe the new built triggered with `git push` command under `Build History` on the Jenkins project page.

- Explain the built results, and show the output from the shell.

- Connect to Jenkins Server instance with SSH. 

- Show that there is no image locally on the server.

```bash

```

- Run the `todo-app` directly from the ECR Repo.

```bash

```

- Show the change on the To-Do App by entering `http://<ec2-host-name>` in a browser.

- Stop and remove container

```bash

```

- Delete the all local images of `todo-app`.

```bash

```

## Part 4 - Cleaning up the Image Repository on AWS ECR

- If necessary, authenticate the Docker CLI to your default `ECR registry`.

```bash

```

- Delete Docker image from `clarusway-repo/todo-app` ECR repository from AWS CLI.

```bash

```

- Delete the ECR repository `clarusway-repo/todo-app` from AWS CLI.

```bash

```

- Check if the image and repository of `callahan-repo/todo-app` is deleted from AWS ECR Console.
