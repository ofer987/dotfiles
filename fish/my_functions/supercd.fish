# Get the file/directory's parent
function get_parent
  set items (string split / $argv[1])
  set count (count $items)

  set count (math $count - 1)

  set i 0
  set result ""
  for item in $items
    if test -n $item && test $i -lt $count
      set result "$result/$item"
    end

    set i (math $i + 1)
  end

  echo $result
end

# Change  into the file's directory
function supercd
  set dir $argv[1];

  if test -z $dir
    return 1;
  end

  while test -n $dir
    if test -d $dir
      cd $dir
      return 0
    else
      set parent (get_parent $dir)
      set dir $parent
    end
  end

  return 1
end

alias "ccd=supercd"
