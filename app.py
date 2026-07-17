from fastapi import FastAPI, HTTPException
from prometheus_fastapi_instrumentator import Instrumentator
import time
import os

app = FastAPI()

Instrumentator().instrument(app).expose(app)

@app.get("/")
def home():
    return {
        "application": "DeploySafe",
        "service": "Order Service",
        "version": "v4 - analysis pre-promotion",
        "status": "running"
    }

@app.get("/health")
def health():
    return {
        "status": "healthy"
    }

@app.get("/slow")
def slow():
    time.sleep(10)
    return {
        "message": "This was slow."
    }

@app.get("/error")
def error():
    raise HTTPException(
        status_code=500,
        detail="Simulated Internal Server Error"
    )

@app.get("/crash")
def crash():
    os._exit(1)