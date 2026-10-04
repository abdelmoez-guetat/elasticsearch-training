# Elasticsearch Certification Simulator (CK-X Style) 🚀

A realistic, interactive, exam-like practice environment for Elasticsearch certification preparation.

## Features
- **Split-Screen UI**:
  - **Left Pane**: Exam questions (all 23 exercises from `QUESTIONS.md`), category badges, dataset notices, 2-hour countdown timer, and submission modal.
  - **Right Pane**: Embedded Web Terminal (`ttyd`) and Web Navigator (Elastic Documentation homepage + embedded Kibana interface).
- **Automated Verification System**: Real-time evaluation API checking cluster state for each question and returning pass/fail results + final score percentage.
- **Dockerized Setup**: Single command execution via `docker-compose up`. Only the main web interface (port 80) is exposed to the host machine.

## How to Run
```bash
docker-compose up -d --build
```
Then open http://localhost in your browser.
