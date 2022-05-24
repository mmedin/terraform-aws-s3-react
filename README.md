Español? [Aquí](README.es.md)

# terraform-aws-s3-react

A beginner's tutorial for deploying a React app on an AWS S3 bucket with the help of Terraform and the AWS CLI.

![Diagram](/img/diagram.png?raw=true 'Diagram')

## Prerequisites

We need to have [NodeJS](https://nodejs.org/es/download/ 'NodeJS Download Page'). The example ReactJS app inside this repo was created with v14.19.3. To check the version we currently have:

```console
node -v
```

We also need to have the AWS command line tool (AWS CLI) and Terraform. The Terraform code we will work with is tested on v1.0.8. It may require adjustments to work with other versions.

## Preparing the app react that we will upload

There is already a sample ReactJS application as part of this repo. For those who prefer to create their own version, you can do it like this:

```console
npm install react-scripts@latest
npm init react-app sample-react-app
```
