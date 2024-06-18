var express = require('express');
var os = require("os");
var fs = require('fs');
const NodeCache = require('node-cache');
const myCache = new NodeCache();
var router = express.Router();


myCache.set( "uncode", "verysecret");


const crypto = require('crypto');

const algorithm = 'aes-256-ctr';
const secretKey = '32charstring';
const iv = crypto.randomBytes(16);

const encrypt = (text, secretKey) => {

    const cipher = crypto.createCipheriv(algorithm, secretKey, iv);

    const encrypted = Buffer.concat([cipher.update(text), cipher.final()]);

    return {
        iv: iv.toString('hex'),
        content: encrypted.toString('hex')
    };
};

const decrypt = (hash, secretKey) => {

    const decipher = crypto.createDecipheriv(algorithm, secretKey, Buffer.from(hash.iv, 'hex'));

    const decrpyted = Buffer.concat([decipher.update(Buffer.from(hash.content, 'hex')), decipher.final()]);

    return decrpyted.toString();
};

// const result = encrypt('example');
// console.log(result);

// const word = decrypt(result, secretKey);
// console.log(word)


router.get('/decrypt/:password', function(req, res, next) {
  const todecrypt = {
    iv: 'c3fc27052cf108c874f1a2541dca161a',
    content: 'ec75a7619fd57c622fa1aefbf46131b8da7cf72a98aace4660753578d8'
  }

  const lowerPwd = req.params.password.toLowerCase();
  var generatedSecretKey = "";

  while (generatedSecretKey.length < 32) {
    generatedSecretKey += lowerPwd;
  }

  const mySecretKey = generatedSecretKey.substring(0,32);

  const result = decrypt(todecrypt, mySecretKey)

  res.json({
    result: result
  });
});



/* GET home page. */
router.get('/', function(req, res, next) {
  res.json({
    time: new Date(),
    environment: process.env.NODE_ENV,
    hostname: os.hostname(),
    path: "/"
  });
});

router.get('/path/:pathParam', function(req, res, next) {
  res.json({
    time: new Date(),
    environment: process.env.NODE_ENV,
    hostname: os.hostname(),
    path: req.params.pathParam
  });
});

router.get('/store/:key', function(req, res, next) {
  const value = myCache.get(req.params.key);

  if ( value == undefined ) {
    res.send({ found: false})
  }

  res.send(value);
});

router.get('/store/:key/secret/:secret', function(req, res, next) {
  const success = myCache.set( req.params.key, req.params.secret);

  res.send({ written: success});
});

router.get('/store', function(req, res, next) {
  fs.readFile('store.database', 'utf-8', function (err, data) {
    if (err) {
      res.send({ status: 'nothing found in file'})
    }

    res.send({ store_content: data});
  });

});

router.get('/key', function(req, res, next) {
    res.send("this is my key");
});

router.get('/decipher/:value/key/:key', function(req, res, next) {
    res.send("this is my key");
});

module.exports = router;
