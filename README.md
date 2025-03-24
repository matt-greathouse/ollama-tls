# ollama-tls
Ollama is one of the easiest ways to get started with running LLMs on your local machine. It provides a command line interface and a server for making requests via a standard API. Unfortunately, Ollama is primarily meant to be queried on the same system that it is running on, and as such does not support HTTPS encyption for API requests.
This project provides a docker compose configuration that will start a standard Ollama server, but route all requests through an nginx reverse proxy. It still respects the default Ollama port, 11434, but only allows HTTPS requests.

## To get started:
Getting started is simple. After pulling down this repository, `cd` into its main directory. Then, follow these steps to set up certs:

### CERT SETUP
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

4. Create a Certificate Authority (CA)
```
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days 1825 -out ca.crt
```

5. Generate a Client Private Key
```
openssl genrsa -out client.key 2048
```

6. Create a Client Certificate Signing Request (CSR)
```
openssl req -new -key client.key -out client.csr
```

7. Create a Client Certificate signed by the CA:
```
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365 -sha256
```

### Running the Container
After your certificates are in order, run `docker compose up` to start the ollama server and reverse proxy. You should now be able to make requests to the ollama server via HTTPS while passing the client.key and client.crt generated above.