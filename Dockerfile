FROM python:latest
WORKDIR /app
COPY hello.py .
CMD ["python", "hello.py"]
