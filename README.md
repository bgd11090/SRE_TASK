# sre_task

Flask aplikacija sa health i metrics endpointima

## Aplikacija

Jednostavna web aplikacija u Pythonu(Flask) sa dva endpointa:

- `/health` - vraca status aplikacije i timestamp
- `/metrics` - vraca ukupan broj requestova od pokretanja

Port: 3000

## Pokretanje lokalno

```bash
cd app
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 app.py
```

Aplikacija ce raditi na http://localhost:3000

## Docker

Build:
```bash
docker build -t sre-app ./app
```

Run (spolja port 80, unutra 3000):
```bash
docker run -p 80:3000 sre-app
```

## CI/CD

GitHub Actions workflow (`.github/workflows/docker.yml`) koji:
- Trigeruje se na push na main branch
- Builduje Docker image
- Pushuje na GitHub Container Registry (ghcr.io)

Image dostupan na: `ghcr.io/bgd11090/sre_task:latest`

Pull i run:
```bash
docker pull ghcr.io/bgd11090/sre_task:latest
docker run -p 80:3000 ghcr.io/bgd11090/sre_task:latest
```

## Optimizacije

- Koriscen `python:3.12-alpine` kao base image jer je manji
- `--no-cache-dir` flag pri pip install da ne cuva cache
- `.dockerignore` da ne kopira venv, .git itd.
- requirements.txt se kopira pre koda zbog boljeg Docker layer kesiranja

## Zapazanja

- README.md link iz teksta zadatka vodi na "https://dealsbe.com/" gde se odigrala jedna lagana partija saha :)

- Timestamp format u pocetku sam vracao `datetime.utcnow()` direktno ali zadatak trazi drugaciji format sa Z sufiksom. Resenje je bilo koristiti `.strftime('%Y-%m-%dT%H:%M:%SZ')` da dobijem taj format `2026-02-25T15:30:00Z`

# Terraform (DRUGI ZADATAK)

Struktura zadatka je zamisljena da bude sa modularnim pristupom:
- `ecs_module/` - modul sa clusterom, task definicijom, servisom i cloudwatch log grupom
- `providers.tf` - AWS provider sa mock kredencijalima za testiranje
- `outputs.tf` - output za cluster i service name
- `variables.tf` i `terraform.tfvars` - konfiguracija na root nivou

Razvoj je isao redosledom po tackama iz zadatka:
1. ECS klaster - poceo sam sa `aws_ecs_cluster` resursom i varijablom za ime klastera
2. Task definicija - dodao sam `aws_ecs_task_definition` sa container konfiguracijom
3. CloudWatch logove - kreirao sam  `aws_cloudwatch_log_group` i povezao sa task definicijom
4. IAM role - dodao sam `aws_iam_role` i `AmazonECSTaskExecutionRolePolicy` za potrebne dozvole
5. ECS servis - na kraju sam kreirao i `aws_ecs_service`
6. Parametrizacija - neke zaostale hardkodovane parametre samo promenio da budu promenljive (region, log retention period)
7. Dokumentacija

## Izazovi i resenja

- Terraform plan greska - imao sam error "invalid AWS Region" jer `region` parametar u AWS provider-u nije bio postavljen. Razlog je bio jer sam samo uradio copy/paste primera iz zadatka. Dodavanje `region = "us-east-1"` je resilo ovaj problem.

- Environment varijable - prvo sam mislio da mogu direktno da koristim `var.app_env` u `environment` bloku, ali ECS ocekuje listu objekata. Resenje je bilo dodati for petlju.

## Pokretanje

```bash
cd terraform
terraform init
terraform plan 
```