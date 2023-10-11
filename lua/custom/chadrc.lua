local M = {}

M.ui = require "custom.ui"
M.mappings = require "custom.mappings"

-- 
package["lab/gx"] = nil
require("lab/gx")

return M
