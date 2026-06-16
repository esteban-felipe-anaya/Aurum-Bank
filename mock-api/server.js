const jsonServer = require('json-server');

const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();

server.use(middlewares);
server.use(jsonServer.bodyParser);

// Custom auth + transfer routes (registered BEFORE the rewriter/router so they take precedence)
server.post('/auth/login', (req, res) => {
  const db = router.db;
  const user = db.get('users').nth(0).value();
  res.status(200).jsonp({
    token: 'mock-jwt-token-' + Date.now(),
    user: user,
  });
});

server.post('/auth/register', (req, res) => {
  res.status(201).jsonp({
    token: 'mock-jwt-token-' + Date.now(),
    user: {
      id: 'usr_new',
      name: req.body.name || 'New User',
      email: req.body.email || 'new@demo.app',
      phone: null,
      avatarColor: '#6C5CE7',
    },
  });
});

server.post('/transfers', (req, res) => {
  res.status(201).jsonp({
    id: 'trf_' + Date.now(),
    status: 'completed',
    fromAccountId: req.body.fromAccountId,
    toBeneficiaryId: req.body.toBeneficiaryId,
    amount: req.body.amount,
    fee: req.body.fee || 0,
    date: new Date().toISOString(),
  });
});

// Change password — validates only that a current + new password were sent.
server.post('/auth/change-password', (req, res) => {
  const { currentPassword, newPassword } = req.body || {};
  if (!currentPassword || !newPassword) {
    return res.status(400).jsonp({ message: 'Both passwords are required.' });
  }
  if (String(newPassword).length < 8) {
    return res
      .status(400)
      .jsonp({ message: 'New password must be at least 8 characters.' });
  }
  res.status(200).jsonp({ ok: true, changedAt: new Date().toISOString() });
});

// Nice REST URL rewrites, then the json-server router
server.use(jsonServer.rewriter(require('./routes.json')));
server.use(router);

const port = process.env.PORT || 3000;
server.listen(port, '0.0.0.0', () => {
  console.log(`Mock API running at http://localhost:${port}`);
});
