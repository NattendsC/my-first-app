// Script avec vulnérabilité SQL Injection pour tester Snyk SAST
const express = require('express');
const app = express();

app.get('/user', (req, res) => {
  const userId = req.query.id;
  const query = "SELECT * FROM users WHERE id = " + userId; // SQL Injection vulnerability
  res.send(query);
});

app.listen(3000);
