English? [Here](README.md)

# terraform-aws-s3-react

Una guía para principiantes para desplegar una app React en un bucket S3 de AWS con la ayuda de Terraform y el CLI de AWS.

![Diagrama](/img/diagram.png?raw=true 'Diagrama')

## Pre-requisitos

Necesitamos contar con NodeJS. La app ReactJS de ejemplo dentro de este repo fue creada con la v16.18.1. Para verificar la versión que tenemos:

```console
node -v
```

También necesitamos contar con la herramienta de línea de comandos AWS [CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) y [Terraform](https://www.terraform.io/downloads). El código Terraform que trabajaremos está probado sobre la v1.0.8. Podría requerir ajustes para funcionar con otras versiones.

## Creando el bucket S3 con Terraform

Utiliaremos Terraform para crear el bucket S3 con características de sitio web y una política que permite la lectura pública. Para esto utilizaremos el código incluido en [aws-s3-bucket-website.tf](aws-s3-bucket-website.tf). De este archivo, lo único que debiéramos modificar es el nombre del bucket:

```terraform
variable "bucket_name" {
  default = "a-react-app-in-s3"
}
```

Para empezar, parados en la raíz de este repo prepararemos terraform con el parámetro `init`:

```console
terraform init
```

Luego de inicializado el proyecto usamos `plan` para obtener el detalle de los cambios que Terraform hará, en este caso en AWS:

```console
terraform plan
```

Si estamos de acuerdo con el detalle, finalmente ejecutamos el `apply` para aprovisionar nuestro bucket:

```console
terraform apply
```

Al final obtendremos la URL con la que podremos acceder al bucket desde cualquier browser. El formato será `http://[bucket].s3-website-[region].amazonaws.com/`.

## Preparando la react app que subiremos

Ya hay una aplicación ReactJS de ejemplo como parte de este repo. Para quienes prefieran crear su propia versión, podrán hacerlo así:

```console
npm install react-scripts@latest
npm init react-app sample-react-app
```

Necesitamos compilar la app para obtener el set de archivos estáticos (html, css, js, etc) que conformarán nuestro sitio web:

```console
cd sample-react-app
npm install
npm run build
```

## Desplegando la aplicación

Lo que queda para poder acceder a tal dirección y ver nuestra app react en vivo es copiar el contenido. Lo hacemos con la ayuda del AWS CLI y el siguiente comando:

```console
aws s3 sync sample-react-app/build s3://a-react-app-in-s3
```

## Limpieza final

Para asegurarnos de dejar la cuenta de AWS limpia y no generar gastos no deseados, con la ayuda de terraform podemos eliminar los objetos que hemos creado. Previamente debemos vaciar el bucket.

```console
aws s3 rm --recursive s3://a-react-app-in-s3/
terraform destroy
```
