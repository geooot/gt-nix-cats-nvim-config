local ai = nixCats("ai")
if not ai or not ai.enable then
  return
end

local provider = ai.provider or "bedrock"
local model = ai.model or "us.anthropic.claude-sonnet-4-20250514-v1:0"
local aws_profile = ai.awsProfile or "default"

local opts = {
  virtualtext = {
    auto_trigger_ft = { "*" },
    keymap = {
      accept = "<A-A>",
      accept_line = "<A-a>",
      accept_n_lines = "<A-z>",
      prev = "<A-[>",
      next = "<A-]>",
      dismiss = "<A-e>",
    },
  },
  throttle = 1500,
  debounce = 600,
  request_timeout = 0,
  notify = "warn",
}

if provider == "bedrock" then
  local region = "us-east-1"

  opts.provider = "openai_compatible"
  opts.provider_options = {
    openai_compatible = {
      end_point = "https://bedrock-runtime." .. region .. ".amazonaws.com/v1/chat/completions",
      api_key = "TERM",
      model = model,
      name = "Bedrock",
      stream = true,
      optional = {
        max_tokens = 512,
      },
    },
  }
  local function get_sigv4_args()
    local creds = vim.fn.system("aws configure export-credentials --profile " .. aws_profile .. " --format process --output json")
    if vim.v.shell_error ~= 0 then
      vim.notify("minuet: aws credentials command failed (exit " .. vim.v.shell_error .. ")", vim.log.levels.ERROR)
      return {}
    end
    local ok, parsed = pcall(vim.json.decode, creds)
    if not ok then
      vim.notify("minuet: failed to parse credentials JSON", vim.log.levels.ERROR)
      return {}
    end
    local args = {
      "--aws-sigv4", "aws:amz:" .. region .. ":bedrock",
      "--user", parsed.AccessKeyId .. ":" .. parsed.SecretAccessKey,
    }
    if parsed.SessionToken then
      table.insert(args, "-H")
      table.insert(args, "x-amz-security-token: " .. parsed.SessionToken)
    end
    return args
  end

  opts.curl_extra_args = {}

  opts.provider_options.openai_compatible.transform = {
    function(data)
      require("minuet").config.curl_extra_args = get_sigv4_args()
      return data
    end,
  }
else
  opts.provider = provider
  opts.provider_options = {
    [provider] = {
      model = model,
    },
  }
end

require("minuet").setup(opts)
