# Stage 1 - Builder
FROM python:3.12-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

# Stage 2 - Final image
FROM python:3.12-slim

WORKDIR /app

COPY --from=builder /install /usr/local
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]