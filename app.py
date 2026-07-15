from fastapi import FastAPI, HTTPException
import time
import os

app = FastAPI()

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
