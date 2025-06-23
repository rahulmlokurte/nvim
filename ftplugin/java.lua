local jdtls = require 'jdtls'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/Users/rahul.lokurte/neo-java/' .. project_name

local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
local bundles = {
  vim.fn.glob('/Users/rahul.lokurte/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/*.jar', true),
}

vim.list_extend(bundles, vim.split(vim.fn.glob('/Users/rahul.lokurte/.local/share/nvim/mason/packages/java-test/extension/server/*.jar', true), '\n'))

local config = {
  capabilities = lsp_capabilities,
  cmd = {
    '/opt/homebrew/opt/openjdk@21/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:/Users/rahul.lokurte/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    '/Users/rahul.lokurte/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar',
    '-configuration',
    '/Users/rahul.lokurte/.local/share/nvim/mason/packages/jdtls/config_mac_arm/',
    '-data',
    workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  settings = {
    java = {
      -- Enable code formatting
      format = {
        enabled = false,
        -- Use IntelliJ IDEA Default style for code formatting
        settings = {
          url = vim.fn.stdpath 'config' .. '/java-intellij-default.xml',
          profile = 'Default',
        },
      },
      formatOnType = {
        enabled = true,
      },
      -- Enable downloading archives from eclipse automatically
      eclipse = {
        downloadSources = true,
      },
      -- Enable downloading archives from maven automatically
      maven = {
        downloadSources = true,
      },
      -- Enable method signature help
      signatureHelp = {
        enabled = true,
      },
      -- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
      contentProvider = {
        preferred = 'fernflower',
      },
      -- Setup automatic package import organization on file save
      saveActions = {
        organizeImports = true,
      },
      -- Customize completion options
      completion = {
        -- When using an unimported static method, how should the LSP rank possible places to import the static method from
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
        -- Try not to suggest imports from these packages in the code action window
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
        -- Set the order in which the language server should organize imports
        importOrder = {
          'java',
          'jakarta',
          'javax',
          'com',
          'org',
        },
      },
      sources = {
        -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
        organizeImports = {
          starThreshold = 9999,
          staticThreshold = 9999,
        },
      },
      -- How should different pieces of code be generated?
      codeGeneration = {
        -- When generating toString use a json format
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        -- When generating hashCode and equals methods use the java 7 objects method
        hashCodeEquals = {
          useJava7Objects = true,
        },
        -- When generating code use code blocks
        useBlocks = true,
      },
      -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
      configuration = {
        updateBuildConfiguration = 'interactive',
      },
      -- enable code lens in the lsp
      referencesCodeLens = {
        enabled = true,
      },
      -- enable inlay hints for parameter names
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
      -- Add compiler arguments to preserve parameter names
      compile = {
        nullAnalysis = {
          mode = 'automatic',
        },
      },
      -- Add JVM arguments for compilation
      jvm = {
        args = { '-parameters' },
      },
    },
  },
  handlers = {
    ['$/progress'] = function(_, _, _)
      -- disable progress updates.
    end,
  },
  init_options = {
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    bundles = bundles,
    -- Add JVM arguments to include -parameters flag for Spring Boot parameter name resolution
    jvm_args = { '-parameters' },
  },
}

jdtls.start_or_attach(config)
