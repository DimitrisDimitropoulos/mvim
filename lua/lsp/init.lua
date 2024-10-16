vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    if true then
      vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      local inlay_hints_group = vim.api.nvim_create_augroup('InlayHintAuto', { clear = false })
      vim.defer_fn(function()
        local mode = vim.api.nvim_get_mode().mode
        vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = args.buf })
      end, 500)
      vim.api.nvim_create_autocmd('InsertEnter', {
        group = inlay_hints_group,
        desc = 'Enable inlay hints',
        buffer = args.buf,
        callback = function()
          vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
        end,
      })
      vim.api.nvim_create_autocmd('InsertLeave', {
        group = inlay_hints_group,
        desc = 'Disable inlay hints',
        buffer = args.buf,
        callback = function()
          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end,
      })
    end

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = vim.g.border_style })
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = vim.g.border_style })
    for _, lsp in ipairs { 'diagnostics', 'maps', 'format' } do
      require('lsp.' .. lsp)
    end
  end,
})
