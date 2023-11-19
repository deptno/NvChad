local cookie = vim.fn.system("kubectl get secret test.cookie -o jsonpath='{.data.cookie}' | base64 -d | tr -d '\n'")
vim.g.vrc_curl_opts = {
  ["-b"] = cookie
}
