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

// Nice REST URL rewrites, then the json-server router
server.use(jsonServer.rewriter(require('./routes.json')));
server.use(router);

server.listen(3000, '0.0.0.0', () => {
  console.log('Mock API running at http://localhost:3000');
});
