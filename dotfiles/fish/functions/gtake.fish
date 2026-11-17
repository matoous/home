function gtake --argument-names repo --description "Clone a GitHub org/repo into ~/code/github.com and cd into it."
    echo $repo
    git clone "https://github.com/$repo" "$HOME/code/github.com/$repo"
    echo "https://github.com/$repo" >>"$HOME/code/repositories.txt"
    cd "$HOME/code/github.com/$repo"
end
