function update --description "Update common package managers and developer toolchains."
    brew update; and brew upgrade
    fisher update
    gup update
    npm update -g
    rustup update
    cargo install-update -a
end
