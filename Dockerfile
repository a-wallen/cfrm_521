FROM python:3.11

# -------------------------------------------------------------------
# HOST MACHINE NOTES:
# 1. VSCode: [https://code.visualstudio.com/Download](https://code.visualstudio.com/Download)
# 2. Docker: Ensure Docker Desktop is installed and running on your host.
# -------------------------------------------------------------------

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /app

# Install system utilities and Quarto (latest stable)
RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip curl ca-certificates && \
    curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb && \
    dpkg -i quarto-linux-amd64.deb && \
    rm quarto-linux-amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the startup script
COPY start.py /usr/local/bin/

# Use start.py to handle data downloads and git hooks before sleeping
ENTRYPOINT ["python", "/usr/local/bin/start.py"]
CMD ["sleep", "infinity"]
