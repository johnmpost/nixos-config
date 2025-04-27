local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = { "prettier" },
    ledger = { "hledgerfmt" },
    markdown = { "prettier" },
    ["*"] = { "trim_newlines" },
  },

  formatters = {
    hledgerfmt = {
      command = "sh",
      args = {
        "-c",
        [[
          {
            tmpfile=$(mktemp) || exit 1
            trap 'rm -f "$tmpfile" EXIT'
            cat - > "$tmpfile"

            {
              awk '/^[0-9]{4}-[0-9]{2}-[0-9]{2}/ {exit} {print}' "$tmpfile"
              hledger print -n -f "$tmpfile" --round=soft -x --pager=N
            } || cat "$tmpfile"
          }
        ]],
      },
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
