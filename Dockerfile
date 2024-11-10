# Dockerfile for FastAPI application
FROM python:3.10
WORKDIR /app
COPY pyproject.toml .
RUN pip install --no-cache-dir -e .[dev]
COPY ./app /app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8008", "--reload"]