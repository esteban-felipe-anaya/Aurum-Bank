# Flutter Fintech Mock API

A runnable [json-server](https://github.com/typicode/json-server) (0.17.x classic) mock REST API for the Flutter fintech (banking) demo app.

## Install

```bash
npm install
```

## Run

```bash
# Full mode: includes /auth/login, /auth/register and /transfers custom handlers
npm run start:custom

# Plain CRUD mode (no custom POST handlers, but rewrites still apply)
npm start
```

Default base URL: **http://localhost:3000**

## Endpoints

### Resources (CRUD via json-server)
- `GET    /users`            — list users (`GET /users/usr_01` for one)
- `GET    /accounts`         — list accounts
- `GET    /cards`            — list cards
- `PATCH  /cards/:id`        — toggle freeze, e.g. `{ "frozen": true }` (works out of the box)
- `GET    /transactions`     — list transactions (supports json-server filtering, e.g. `?accountId=acc_01&_sort=date&_order=desc`)
- `GET    /beneficiaries`    — list beneficiaries
- `GET    /notifications`    — list notifications (`PATCH /notifications/:id` to mark read)

### Rewritten REST URLs (`routes.json`)
- `GET    /insights/spending` — single spending-insights object (maps to `/spending`)
- `GET    /auth/me`           — current user (maps to `/users/usr_01`)

### Custom handlers (only in `npm run start:custom`)
- `POST   /auth/login`    — `200 { token, user }`
- `POST   /auth/register` — `201 { token, user }` (body: `name`, `email`)
- `POST   /transfers`     — `201 { id, status, fromAccountId, toBeneficiaryId, amount, fee, date }`

## Notes
- `db.json` is the seed database (40 transactions across 3 accounts).
- In plain `npm start` mode the `/auth/*` and `/transfers` POST handlers are not available — use `npm run start:custom` for those.
