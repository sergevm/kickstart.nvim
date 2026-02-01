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
      -- Core prompts
      Explain = 'Explain how this code works:',
      Review = 'Review this code and suggest improvements:',
      Tests = 'Write tests for this code:',
      Docs = 'Write documentation for this code:',

      -- Copilot Pro enhanced prompts
      Refactor = 'Refactor this code for better performance, readability, and maintainability. Consider:\n- Time and space complexity\n- Readability and clarity\n- SOLID principles\n- Code smells and antipatterns\n- Modern language features',

      Debug = 'Help me debug this code. Analyze for potential issues:\n- Edge cases and boundary conditions\n- State management problems\n- Logic errors and infinite loops\n- Performance bottlenecks\n- Type safety issues\n- Common pitfalls in this language/framework',

      Architecture = 'Review the architecture and design of this code. Suggest improvements for:\n- Separation of concerns\n- Modularity and reusability\n- Scalability and extensibility\n- Design patterns and best practices\n- Integration points and dependencies\n- Future maintenance considerations',

      Security = 'Analyze this code for security vulnerabilities and risks:\n- Input validation and sanitization\n- Authentication and authorization\n- Data exposure and sensitive information\n- OWASP vulnerabilities\n- Dependency security issues\n- Secure coding practices',

      Performance = 'Analyze the performance characteristics of this code:\n- Time complexity (Big O notation)\n- Space complexity\n- Optimization opportunities\n- Caching strategies\n- Database query efficiency\n- Memory leaks and resource management',

      TypeSafety = 'Improve the type safety and type inference of this TypeScript code:\n- Remove any types where possible\n- Use stricter generic constraints\n- Leverage type inference\n- Use discriminated unions for better type safety\n- Add proper type guards\n- Enable stricter compiler options',

      BestPractices = 'Review this code against modern best practices for this technology:\n- Current ecosystem standards\n- Performance patterns\n- Error handling\n- Concurrency considerations\n- Accessibility (if UI code)\n- Testing strategies',
    },
  },
  cmd = { 'CopilotChat', 'CopilotChatVisual' },
  keys = {
    { '<leader>C', '<cmd>CopilotChat<cr>', desc = 'Copilot Chat' },
    { '<leader>Ce', '<cmd>CopilotChatExplain<cr>', desc = 'Explain code' },
    { '<leader>Ct', '<cmd>CopilotChatTests<cr>', desc = 'Generate tests' },
    { '<leader>Cr', '<cmd>CopilotChatReview<cr>', desc = 'Review code' },
    { '<leader>Crf', '<cmd>CopilotChatRefactor<cr>', desc = 'Refactor code' },
    { '<leader>Cd', '<cmd>CopilotChatDebug<cr>', desc = 'Debug code' },
    { '<leader>Ca', '<cmd>CopilotChatArchitecture<cr>', desc = 'Architecture review' },
    { '<leader>Cs', '<cmd>CopilotChatSecurity<cr>', desc = 'Security review' },
    { '<leader>Cp', '<cmd>CopilotChatPerformance<cr>', desc = 'Performance analysis' },
    { '<leader>Cty', '<cmd>CopilotChatTypeSafety<cr>', desc = 'Type safety check' },
    { '<leader>Cbp', '<cmd>CopilotChatBestPractices<cr>', desc = 'Best practices review' },
  },
}
