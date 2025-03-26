FROM ollama/ollama

ARG MODEL

# Pre-Install provided model
RUN nohup bash -c "ollama serve &" && sleep 5 && ollama pull ${MODEL}
