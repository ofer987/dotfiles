// LaunchBar Action Script

let isHttps = (argument) => {
  if (argument.toLowerCase() === 'https') {
    return true;
  }

  return false;
}

function run(argument) {
  if (!argument) {
    return;
  }

  args = argument.split(" ");

  let schema = 'http';
  if (isHttps(args[0])) {
    schema = 'https';
    args = args.slice(1);
  }

  if (args.length === 2) {
    path = args[1];
    if (path.startsWith("/")) {
      path = path.substring(1)
    }
    path = encodeURI(path);

    uri = `${schema}://localhost:${args[0]}/${path}`;
  } else {
    uri = `${schema}://localhost:${args[0]}`;
  }

  LaunchBar.openURL(uri);
}
