local M = {}

---@param key string secret to fetch
---@return any value
function M.get(key)
  local ok, secrets = pcall(require, "__secrets")
  if not ok then
    return
  end

  return secrets[key]
end

return M
