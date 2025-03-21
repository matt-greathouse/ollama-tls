# ollama-tls

## To get started:
After pulling down this repository, `cd` into its main directory. Then, follow these steps to set up certs:

1. Generate a Private Key
Use the following command to generate a private key:
```
openssl genrsa -out server.key 2048
```
This command creates a 2048-bit RSA private key in a file named server.key.

2. Create a Certificate Signing Request (CSR)
You’ll need to create a CSR to describe the certificate you’re requesting:
```
openssl req -new -key server.key -out server.csr
```
During this process, you’ll be asked to provide information such as your country, state, organization name, and Common Name (CN). The Common Name usually represents the domain name you’re securing (e.g., example.com).

3. Generate a Self-Signed Certificate
If you don’t have a Certificate Authority (CA) or if you are just testing, you can 
```
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```
This command creates a certificate (server.crt) that’s valid for 365 days. The -signkey option indicates the private key to use for signing.