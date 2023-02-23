local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

return {
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}
