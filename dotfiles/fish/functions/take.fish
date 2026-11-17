function take --argument-names target --description "Create and enter a directory, or clone and enter a GitHub repo."
    if string match -rq 'git@github.com:*' $target
        set repo (echo $target | sed 's/^git@github.com:/https:\/\/github.com\//' | sed 's/.git$//')
        set dirname (basename $repo)
        git clone $repo
        cd $dirname
    else
        mkdir -p $target; and cd $target
    end
end
