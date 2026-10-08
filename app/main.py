from fastapi import FastAPI

from .routers import auth

app = FastAPI(title="pulse", version="0.1.0")

app.include_router(auth.router)


@app.get("/healthz")
def healthz():
    return {"status": "ok"}


@app.get("/ping")
def ping():
    return {"pong": True, "service": "pulse", "version": app.version}