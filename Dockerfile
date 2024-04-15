FROM alpine:latest

# add mono repo and mono
RUN apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

# install requirements
RUN apk add --no-cache --upgrade ffmpeg mediainfo python3 git py3-pip python3-dev g++ cargo mktorrent rust

# Create a virtual environment to isolate our package dependencies locally
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Ensure pip is updated in the virtual environment
RUN pip install --upgrade pip

WORKDIR /Upload-Assistant

# Install requirements in the virtual environment
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy everything
COPY . .

ENTRYPOINT ["python3", "/Upload-Assistant/upload.py"]
