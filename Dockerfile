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
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
        build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /temp/requirements.txt && \
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /temp/requirements.dev.txt ; fi && \
    rm -rf /tmp && \
    apk del .tmp-build-deps && \
    id -u django-user &>/dev/null || adduser --disabled-password --no-create-home django-user

# Clean up
RUN rm -rf /temp

# Switch to the django-user
USER django-user

ENV PATH="/py/bin:$PATH"
