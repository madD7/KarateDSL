// Javascript file created to manage Environment variables.
// Keep this file as simple as possible as 
// debugging bugs due to issues in this file will be very difficult.

function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  // config object can be used to default env variables
  var config = {
    apiUrl : 'https://conduit.productionready.io/api/'
  }

  // Customize environment specific config variables 
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }

  return config;
}