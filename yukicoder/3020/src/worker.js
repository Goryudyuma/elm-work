// Example code for Qiita article
const readline = require('readline');
const rl = readline.createInterface(process.stdin, {});

const { Elm } = require('./Worker.elm')

const app = Elm.Worker.init();
app.ports.cout.subscribe(text=>{
  console.log(text);
});

rl.on('line', (line) => {
  app.ports.cin.send(line)
});