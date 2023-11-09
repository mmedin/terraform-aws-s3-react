Español? [Aquí](README.es.md)

# terraform-aws-s3-react

A beginner's tutorial for deploying a React app on an AWS S3 bucket with the help of Terraform and the AWS CLI.

![Diagram](/img/diagram.png?raw=true 'Diagram')

## Prerequisites

We need to have [NodeJS](https://nodejs.org/es/download/ 'NodeJS Download Page'). The example ReactJS app inside this repo was created with v21.1.0. To check the version we currently have:

```console
node -v
```

We also need to have the AWS [CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) (command line tool) and [Terraform](https://www.terraform.io/downloads). The Terraform code we will work with is tested on v1.6.3. It may require adjustments to work with other versions.

## Provisioning the S3 bucket with Terraform

We will use Terraform to create the S3 bucket with website features and a policy that allows public reading. We will use the code included in [aws-s3-bucket-website.tf](aws-s3-bucket-website.tf). From this file, the only thing we should modify is the bucket name:

```terraform
variable "bucket_name" {
  default = "a-react-app-in-s3"
}
```

To start, standing at the root of this repo we will prepare terraform with the `init` parameter:

```console
terraform init
```

After initializing the project we use `plan` to get the details of the changes that Terraform will make, in this case in AWS:

```console
terraform plan
```

If we agree with the detail, we finally run the `apply` to provision our bucket:

```console
terraform apply
```

At the end we will obtain the URL with which we will be able to access the bucket from any browser. The format will be `http://[bucket].s3-website-[region].amazonaws.com/`.

## Preparing the react app that we will upload

There is already a sample ReactJS application as part of this repo. For those who prefer to create their own version, you can do it like this:

```console
npm install react-scripts@latest
npm init react-app sample-react-app
```

We need to build the app to get the set of static files (html, css, js, etc) that will make up our website:

```console
cd sample-react-app
npm install
npm run build
```

## Deploying the application

To be able to access such an address and see our app react live we need to copy the content. We do this with the help of the AWS CLI and the following command:

```console
aws s3 sync sample-react-app/build s3://a-react-app-in-s3
```

## Clean up

To make sure we get the AWS account clean and to avoid generating unwanted expenses, with the help of terraform we can delete the objects created before. Previously we must empty the bucket.

```console
aws s3 rm --recursive s3://a-react-app-in-s3/
terraform destroy
```
