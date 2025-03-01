return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",

    opts = {
      system_prompt = require("CopilotChat.config.prompts").COPILOT_INSTRUCTIONS.system_prompt
        .. [[使用中文回复]],
    },
  },
}
