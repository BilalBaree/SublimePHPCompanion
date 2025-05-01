# Start from a minimal PHP image
FROM php:8.2-cli

# Install dependencies
RUN apt-get update && apt-get install -y unzip git

# Set working directory
WORKDIR /app

# Copy project files into container
COPY . /app

# Default command when container runs
CMD ["php", "-r", "echo 'Container is running!';"]
