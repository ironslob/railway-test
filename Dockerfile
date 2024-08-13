# Use the official Python image as the base image
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the pyproject.toml and poetry.lock files to the container
COPY pyproject.toml poetry.lock /app/

# Install Poetry
RUN pip install --no-cache-dir poetry

# Install dependencies
# RUN poetry install --no-dev --no-interaction --no-ansi
RUN poetry config virtualenvs.create false && poetry install --no-dev --no-interaction --no-ansi

# Copy the rest of the application code to the container
COPY . /app/

# Expose the port the app runs on
EXPOSE 8000

# Run the Flask app using Gunicorn
CMD ["gunicorn", "app:app"]

