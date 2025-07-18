FROM python:3.10-bullseye

# Install Node.js (v19)
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - \
    && apt-get install -y nodejs

# Install system packages
RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg aria2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies
RUN python -m pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Optional: Make sure start.py is executable
RUN chmod +x start.py

# Start the bot
CMD ["python3", "start.py"]
