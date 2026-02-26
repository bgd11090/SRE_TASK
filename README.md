# sre_task

Flask aplikacija sa health i metrics endpointima

## Aplikacija

Jednostavna web aplikacija u Pythonu(Flask) sa dva endpointa:

- `/health` - vraca status aplikacije i timestamp
- `/metrics` - vraca ukupan broj requestova od pokretanja

Port: 3000

## Pokretanje lokalno


cd app
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 app.py


Aplikacija ce raditi na http://localhost:3000

## Docker

Build:
docker build -t sre-app ./app


Run (spolja port 80, unutra 3000):
docker run -p 80:3000 sre-app

## Optimizacije

- Koriscen `python:3.9-alpine` kao base image jer je manji
- `--no-cache-dir` flag pri pip install da ne cuva cache
- `.dockerignore` da ne kopira venv, .git itd.
- requirements.txt se kopira pre koda zbog boljeg Docker layer kesiranja

## Zapazanja

- README.md link iz teksta zadatka vodi na "https://dealsbe.com/" gde se odigrala jedna lagana partija saha :)

- Timestamp format u pocetku sam vracao `datetime.utcnow()` direktno ali zadatak trazi drugaciji format sa Z sufiksom. Resenje je bilo koristiti `.strftime('%Y-%m-%dT%H:%M:%SZ')` da dobijem taj format `2026-02-25T15:30:00Z`