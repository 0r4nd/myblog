# Myblog
### [www.tensormaker.org](http://www.tensormaker.org)

## Source code for my blog:

- Frontend: (React⚛) with js
- Backend: (Uvicorn﻿🦄﻿) + (FastAPI﻿⚡﻿)
- DB: (Postgres ﻿🐘﻿) + (Psycopg3 🖧)

## Ports
- Frontend: 3000
- Backend: 8000
- DB: 5432

## Usage

add:
```shell
127.0.0.1 test.test
127.0.0.1 www.test.test
```
into **C:\Windows\System32\drivers\etc\hosts** file. (run notepad as administrator)

```shell
docker compose up -d --build
```
- Website: [test.test](http://test.test)
- Endpoints: [http://localhost:8000/docs](http://localhost:8000/docs)
- Pgadmin: [http://localhost:8001](http://localhost:8001)
