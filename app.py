from fastapi import FastAPI
import time
import random
import os

app = FastAPI()

@app.get("/")
def home():
    return {"message": "DeplySafe order service is running"}

@app.get("/error")
def error():
    return {"error": "simulated failure"}, 500

@app.get("/slow")
def slow():
    time.slow(10)
    return {"message": "This was slow.."}

@app.get("/crash")
def crash():
    os._exit(1)

@app.get("/health")
def health():
    return {"status" : "healthy"}