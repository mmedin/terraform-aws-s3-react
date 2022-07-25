Español? [Aquí](README.es.md)

# terraform-aws-s3-react

A beginner's tutorial for deploying a React app on an AWS S3 bucket with the help of Terraform and the AWS CLI.

![Diagram](/img/diagram.png?raw=true 'Diagram')

## Prerequisites

We need to have [NodeJS](https://nodejs.org/es/download/ 'NodeJS Download Page'). The example ReactJS app inside this repo was created with v14.19.3. To check the version we currently have:

```console
node -v
```

We also need to have the AWS [CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (command line tool) and [Terraform](https://www.terraform.io/downloads). The Terraform code we will work with is tested on v1.0.8. It may require adjustments to work with other versions.

## Preparing the react app that we will upload

There is already a sample ReactJS application as part of this repo. For those who prefer to create their own version, you can do it like this:

```console
npm install react-scripts@latest
npm init react-app sample-react-app
```

We need to build the app to get the set of static files (html, css, js, etc) that will make up our website:

```console
cd sample-react-app
npm run build
```

## Provisioning the S3 bucket with Terraform

To begin, at the root of the project we initialize Terraform:

```console
terraform init
```

Then we ask terraform to show us what it will do:

```console
terraform plan
```

It should give us a long output that ends with a summary similar to this:

```console
Plan: 4 to add, 0 to change, 0 to destroy.
```

It means that it will create 4 objects, in this case the bucket along with its ACL, policy and web configuration.

Finally we apply the plan:

```console
terraform apply
```

As a result the objects mentioned above will be created, and we will get a URL to access the website. For example:

```console
website_endpoint = "a-react-app-in-s3.s3-website-us-east-1.amazonaws.com"
```

## Deploying the application

To be able to access such an address and see our app react live we need to copy the content. We do this with the help of the AWS CLI and the following command:

```console
aws s3 sync sample-react-app/build s3://a-react-app-in-s3
```

## Final cleaning

To make sure we keep the AWS account clean and avoid generating unwanted expenses, with the help of terraform we can delete the objects we have previously created:

```console
terraform destroy
```
