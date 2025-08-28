FROM python:3.10-slim

# ffmpeg install කරන්න
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# JupyterLab install කරන්න
RUN pip install jupyterlab

# Hugging Face writable paths use කරන්න
ENV JUPYTER_RUNTIME_DIR=/tmp/jupyter_runtime
ENV JUPYTER_DATA_DIR=/tmp/jupyter_data
ENV JUPYTER_CONFIG_DIR=/tmp/jupyter_config

# Hugging Face default port
EXPOSE 7860

# JupyterLab run කරන්න (tokenless, root allow)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=7860", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
