var bs = require('child_process')
process.env.TZ = 'Asia/Jakarta'
function deleteConfigFolder() {
  bs.exec('rm -rf .cache .pki', (error, stdout, stderr) => {
    if (error) {
      console.error(`Error: ${error.message}`);
      return;
    }
    if (stderr) {
     // console.error(`stderr: ${stderr}`);
      return;
    }
   // console.log(`Config folder deleted successfully.`);
  });
}

bs.spawn('bash', [], {
  stdio: ['inherit', 'inherit', 'inherit', 'ipc']
})
