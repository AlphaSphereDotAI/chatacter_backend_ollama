FROM docker.io/ollama/ollama

SHELL [ "/bin/bash", "-c" ]

RUN set -eux; \
    addgroup --system chatacter \
    && adduser --system chatacter --ingroup chatacter

ARG MODEL=hf.co/MaziyarPanahi/Meraj-Mini-GGUF:IQ1_S

RUN /bin/ollama pull $MODEL

USER chatacter

EXPOSE 11434

CMD [ "/bin/ollama", "serve" ]