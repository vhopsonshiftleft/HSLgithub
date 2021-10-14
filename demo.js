#!/usr/bin/env node
 
const bot = require("circle-github-bot").create();
 
bot.comment(`
<h3>"Commit message - "${bot.env.commitMessage}</h3>
`);
