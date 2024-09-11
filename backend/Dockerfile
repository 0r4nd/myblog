FROM python:3.12-slim

# dossier pour l'application
WORKDIR /app

# copie de tous les fichiers et dossiers utiles vers le docker
COPY . /app

# update de pip puis installation de toutes les librairies
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# execute le code depuis le container
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
