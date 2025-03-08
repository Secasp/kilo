# Alpine is not the best for Python services in terms of performance, so we will use the slim version of the official Python image.   
FROM python:3.9-slim AS builder

WORKDIR /app

COPY poetry.lock pyproject.toml /app/

RUN pip install poetry && \
    poetry config virtualenvs.in-project true && \
    poetry install --no-root --no-interaction --no-ansi

FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /app /app
COPY /server /app/server

EXPOSE 5001:5001

CMD ["/app/.venv/bin/flask", "--app", "server.app", "--debug", "run", "--host=0.0.0.0", "--port=5001"]

# I know multi-stage builds are not the best for this situation, but I wanted to show you how to use it.