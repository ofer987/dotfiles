// LaunchBar Action Script

function run(argument) {
  if (!argument) {
    return;
  }

  args = argument.split(" ");
  if (args.length === 2) {
    path = args[1];
    if (path.startsWith("/")) {
      path = path.substring(1)
    }
    path = encodeURI(path);

    uri = `http://localhost:${args[0]}/${path}`;
  } else {
    uri = `http://localhost:${args[0]}`;
  }

  LaunchBar.openURL(uri);
}
