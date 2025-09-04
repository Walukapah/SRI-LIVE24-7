FROM python:3.10-slim

# System dependencies update + Node.js (latest LTS), npm, ffmpeg install කරන්න
RUN apt-get update && apt-get install -y curl gnupg ffmpeg build-essential \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && rm -rf /var/lib/apt/lists/*

# Node.js & npm versions check
RUN node -v && npm -v && ffmpeg -version

# JupyterLab install කරන්න
RUN pip install --no-cache-dir jupyterlab

# Hugging Face writable paths use කරන්න


# Hugging Face default port
EXPOSE 7860

# JupyterLab run කරන්න (tokenless, root allow)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=7860", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
