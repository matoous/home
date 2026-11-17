function debug --description 'One-shot Codex: stronger model, no web, read-only, writes ask first'
    codex exec \
        --ignore-user-config \
        --ephemeral \
        --model gpt-5.4 \
        --sandbox read-only \
        -c 'approval_policy = "on-request"' \
        -c 'web_search = "disabled"' \
        -- $argv
end
