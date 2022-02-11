# Project root of git project
function project
  git rev-parse --show-toplevel 2> /dev/null
end

# Change directory into Project root
function root
  cd (project)
end
