function get_branch_name
  prawler --branch | awk -v number=$argv[1] '
    {
      regex = "^" number
      if ($0 ~ regex) {
        print $0
      }
    }
  ' | cut -f 2 -d ' '
end

function checkout_pull_request
  set -x branch_name (get_branch_name $argv[1])

  git checkout $branch_name
end
