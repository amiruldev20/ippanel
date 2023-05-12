var bs = require('child_process')

bs.spawn('bash', [], {
  stdio: ['inherit', 'inherit', 'inherit', 'ipc']
})
