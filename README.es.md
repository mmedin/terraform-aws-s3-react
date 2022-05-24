English? [Here](README.md)

# terraform-aws-s3-react

Una guía para principiantes para desplegar una app React en un bucket S3 de AWS con la ayuda de Terraform y el CLI de AWS.

![Diagrama](/img/diagram.png?raw=true 'Diagrama')

## Pre-requisitos

Necesitamos contar con NodeJS. La app ReactJS de ejemplo dentro de este repo fue creada con la v14.19.3. Para verificar la versión que tenemos:

```console
node -v
```

También necesitamos contar con la herramienta de línea de comandos de AWS (AWS CLI) y Terraform. El código Terraform que trabajaremos está probado sobre la v1.0.8. Podría requerir ajustes para funcionar con otras versiones.

## Preparando la app react que subiremos

Ya hay una aplicación ReactJS de ejemplo como parte de este repo. Para quienes prefieran crear su propia versión, podrán hacerlo así:

```console
npm install react-scripts@latest
npm init react-app sample-react-app
```
