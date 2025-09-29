<<<<<<< HEAD
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

=======
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

>>>>>>> b1b4f410bf2dfd9afe2f3c757fb09bf178e89bce
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8080", "--reload"]