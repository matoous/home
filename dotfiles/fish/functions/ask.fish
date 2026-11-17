function ask --description "One-shot Codex, or open a Slack DM by nickname"
    switch "$argv[1]"
        case johannes
            open 'slack://user?team=T02GCFTGQ&id=U04AZ65FMB5'
            return
        case leo
            open 'slack://user?team=T02GCFTGQ&id=U01BHACBRMJ'
            return
        case leila
            open 'slack://user?team=T02GCFTGQ&id=U05K8T84P63'
            return
    end

    codex exec \
        --ignore-user-config \
        --ephemeral \
        --model gpt-5.4-mini \
        -c 'approval_policy = "never"' \
        -c 'web_search = "live"' \
        -c 'default_permissions = "ask"' \
        -c 'permissions.ask.network.enabled = true' \
        -- $argv
end
