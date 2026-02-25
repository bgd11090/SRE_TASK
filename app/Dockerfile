FROM python:3.9-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=5s \
  CMD wget http://localhost:3000/health || exit 1
CMD ["python", "app.py"]