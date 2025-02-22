FROM docker.io/ollama/ollama:latest

SHELL [ "/bin/bash", "-c" ]

LABEL org.opencontainers.image.description="Ollama container with a pre-pulled model (hf.co/MaziyarPanahi/Meraj-Mini-GGUF:IQ1_S)"

RUN set -eux; \
    addgroup --system chatacter \
    && adduser --system chatacter --ingroup chatacter

ARG MODEL=hf.co/MaziyarPanahi/Meraj-Mini-GGUF:IQ1_S

# Start ollama serve in the background, wait for it to be ready, then pull the model
RUN /bin/ollama serve & \
    sleep 5 && \
    /bin/ollama pull "$MODEL" && \
    kill $(pidof ollama)

USER chatacter

EXPOSE 11434

# Ensure the ollama service is running
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:11434/health || exit 1

CMD [ "/bin/ollama", "serve" ]