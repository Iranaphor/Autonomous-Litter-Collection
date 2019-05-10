//To use command line call node index path/to/image.png path/to/data/output.json

//import file management
var fs = require('fs');
const args = process.argv;
var imageFile = fs.readFileSync(args[2]);

// Convert the image data to a Buffer and base64 encode it.
var encoded = Buffer.from(imageFile).toString('base64');
var resquest = {requests:[{image:{content:encoded},features:[{type:"LABEL_DETECTION",maxResults:1}]}]}
fs.writeFile(args[3],JSON.stringify(resquest), 'utf8');

