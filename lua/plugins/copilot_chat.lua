return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' }, -- Required
  },
  opts = {
    debug = false,
    show_help = true,
    telescope = { enabled = true },
    prompts = {
      Explain = 'Explain how this code works:',
      Review = 'Review this code and suggest improvements:',
      Tests = 'Write tests for this code:',
      Docs = 'Write documentation for this code:',
    },
  },
  cmd = { 'CopilotChat', 'CopilotChatVisual' },
  keys = {
    { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'Copilot Chat' },
    { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'Explain code' },
    { '<leader>ct', '<cmd>CopilotChatTests<cr>', desc = 'Generate tests' },
    { '<leader>cr', '<cmd>CopilotChatReview<cr>', desc = 'Review code' },
  },
}
