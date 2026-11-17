function clean --description "Clean common local development caches and artifacts."
    yarn cache clean
    go clean -modcache -cache
    docker system prune
    brew cleanup
    npm cache clean --force
    colima prune
end
