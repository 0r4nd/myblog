FROM python:3.12-slim

# This prevents Python from writing out pyc files
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED=1

# dossier pour l'application
WORKDIR /app

# copie de tous les fichiers et dossiers utiles vers le docker
COPY . /app

# update de pip puis installation de toutes les librairies
RUN pip install --no-cache-dir --upgrade -r requirements.txt

EXPOSE 8000

# execute le code depuis le container
CMD uvicorn app.main:app --host 0.0.0.0
