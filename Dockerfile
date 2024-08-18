FROM python:3.9-alpine3.13
LABEL maintainer="Natnael Debebe"

ENV PYTHONUNBUFFERED 1

# Copy the requirements files and application code
COPY ./requirements.txt /temp/requirements.txt
COPY ./requirements.dev.txt /temp/requirements.dev.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

ARG DEV=false

# Create and use virtual environment, install dependencies, and handle debug
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /temp/requirements.txt && \
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /temp/requirements.dev.txt ; fi && \
    echo "Contents of /py/bin:" && ls -l /py/bin && \
    echo "Contents of /app:" && ls -l /app

# Clean up
RUN rm -rf /temp

RUN adduser --disabled-password --no-create-home django-user
USER django-user

ENV PATH="/py/bin:$PATH"
