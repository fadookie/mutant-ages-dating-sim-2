const _ = require('lodash');
const fs = require('fs');

const data = fs.readFileSync('test.template.usdf', 'utf8');

const pageIdRegex = /{{PAGE_[\dA-Za-z]+}}/g;
const pageIdTokens = data.match(pageIdRegex);
const pageIds = pageIdTokens.map(token => token.replace("{{", "").replace("}}", ""));

const template = _.template(data);

console.log({pageIdTokens, pageIds });

let pageSubstitutions = {};

for (let i = 0; i < pageIds.length; ++i) {
  const pageIndex = i + 1;
  const pageId = pageIds[i];
  pageSubstitutions[pageId] = pageIndex;
}

const subsitutedDialogue = template(pageSubstitutions);
console.log(subsitutedDialogue);

