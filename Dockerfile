FROM python:3.10-bullseye

# Install Node.js (v19)
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - \
    && apt-get install -y nodejs

# Install required packages
RUN sed -i '/buster-updates/d' /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg aria2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app/
WORKDIR /app/

# Install Python packages
RUN python -m pip install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt

# Run the start command
CMD bash start
