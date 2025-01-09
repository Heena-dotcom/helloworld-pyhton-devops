FROM python:latest
WORKDIR /app
COPY hello.py .
RUN pip install -r requirements.txt
CMD ["python", "hello.py"]
