# FlaskApp
A simple Python/Flask app to deploy using containerization and infrastructure-as-code.

## Goal
In 2–3 hours, containerize this app and deploy it to a managed container service using IaC. Prefer AWS App Runner and/or GCP Cloud Run (either one is acceptable; both are a plus if time permits).

## Prerequisites
- AWS CLI configured with permissions for ECR, App Runner, IAM
- and/or gcloud CLI with permissions for Artifact Registry, Cloud Run, IAM

## Time Allocation Suggestion
- Containerization: 30 minutes
- Infrastructure code: 90 minutes  
- Documentation: 30 minutes

## Getting Started Locally
1. Create a virtualenv and install packages:
   - `python3 -m venv .venv && source .venv/bin/activate`
   - `pip install -r requirements.txt`
2. Run locally:
   - `FLASK_APP=app.py flask run --port 8080`
3. Test:
   - `curl http://localhost:8080/`
   - `curl http://localhost:8080/api/5`

## What to Build
- Container image for the app.
- Infrastructure-as-code to deploy:
  - Option A: AWS App Runner
  - Option B: GCP Cloud Run
  - Option C (stretch): both
- Public URL(s) to reach `/` and `/api/<value>`.
- Basic logging visible in the platform logs.
- Health check endpoint exposed at `/healthz`

## Constraints and Assumptions
- Tools: Terraform preferred (v1.5+). Pulumi or CDK acceptable with a brief justification.
- Container runtime: Docker. Use a simple `Dockerfile`.
- Registries:
  - AWS: ECR (or use App Runner source from GitHub if you prefer).
  - GCP: Artifact Registry.
- State: Local Terraform state file is fine (no need to set up remote state).
- IAM/Project setup: You may assume an account/project exists and credentials are configured. Document any required roles.
- Regions: Single region of your choice.
- Networking: Public access is acceptable.
- Security: No secrets required for the app. Note any security improvements you’d make.

## Definition of Done
- `curl $APP_URL/` returns "Hello, World!"
- `curl $APP_URL/api/5` returns `{"success": true, "answer": 6}`
- `curl $APP_URL/api/10` returns "Caught exception when calculating results: Invalid value!"
- `curl $APP_URL/healthz` returns "ok"
- Platform logs show application startup and request logs

## Deliverables Checklist
- Dockerfile at repo root.
- IaC under `infra/aws/` and/or `infra/gcp/` with:
  - `main.tf`, `variables.tf`, `outputs.tf`
  - `terraform.tfvars.example` (no real secrets)
- Commands to build, push, and deploy, documented in `README` or a simple `Makefile`.
- `terraform plan` and `terraform apply` produce:
  - A service
  - A URL output (e.g., `app_url`)
- Brief write-up in `DECISIONS.md` covering:
  - Tooling choices
  - Assumptions
  - Trade-offs and what you’d do next with more time
- Open a PR with your branch. Assign to Brian Eck.

## Evaluation Criteria
- Correctness: Deploys a reachable service with expected responses.
- Clarity: Repo structure, docs, and commands are easy to follow.
- IaC Quality: Reasonable modules/variables/outputs; readable and minimal.
- Observability: Logging accessible in platform logs; health/readiness considered/discussed.
- Security/Cost: Sensible defaults for least privilege and cost awareness considered/discussed.
- Pragmatism: Fits within 2–3 hours; good trade-offs.

## Stretch Topics (Choose 2-3 to discuss in DECISIONS.md; do not implement fully)
- How would you implement blue/green deployments with this setup?
- What monitoring/alerting would you add for a team supporting this service?
- How would you handle secrets management for database connections?
- What would your CI/CD pipeline look like from git push to production?
- How would you handle this service receiving 10x traffic?
