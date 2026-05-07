FROM python:3.11

# -------------------------------------------------------------------
# HOST MACHINE NOTES:
# 1. VSCode: [https://code.visualstudio.com/Download](https://code.visualstudio.com/Download)
# 2. Docker: Ensure Docker Desktop is installed and running on your host.
# -------------------------------------------------------------------

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV KAGGLE_CONFIG_DIR=/app
WORKDIR /app

# Install unzip (required for extracting Kaggle datasets)
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the startup script and make it executable
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 8888

# Use start.sh to handle data downloads and git hooks before starting Jupyter
ENTRYPOINT ["/usr/local/bin/start.sh"]
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
