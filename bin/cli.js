#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const packageDir = path.dirname(__dirname);

function showHelp() {
  console.log(`
📦 Markdown Toolkit - Complete Linting Solution

Usage:
  markdown-toolkit <command> [options]

Commands:
  setup     Set up markdown linting in current project
  fix       Fix all markdown errors in current project
  help      Show this help message

Examples:
  markdown-toolkit setup    # Install and configure markdown linting
  markdown-toolkit fix      # Fix all markdown errors

For more information: https://github.com/Neoneue/markdown-toolkit
`);
}

function runCommand(command, description) {
  console.log(`🔧 ${description}...`);
  try {
    execSync(command, { 
      stdio: 'inherit',
      cwd: process.cwd()
    });
    console.log(`✅ ${description} completed!`);
  } catch (error) {
    console.error(`❌ ${description} failed:`, error.message);
    process.exit(1);
  }
}

function copyFile(src, dest, description) {
  try {
    const srcPath = path.join(packageDir, src);
    const destPath = path.join(process.cwd(), dest);
    
    if (fs.existsSync(srcPath)) {
      fs.copyFileSync(srcPath, destPath);
      console.log(`✅ Copied ${description}`);
    } else {
      console.warn(`⚠️  Source file not found: ${src}`);
    }
  } catch (error) {
    console.error(`❌ Failed to copy ${description}:`, error.message);
  }
}

const command = process.argv[2];

switch (command) {
  case 'setup':
    console.log('🚀 Setting up markdown linting...');
    
    // Copy configuration files
    copyFile('.markdownlint.json', '.markdownlint.json', 'markdownlint config');
    copyFile('.lintstagedrc.json', '.lintstagedrc.json', 'lint-staged config');
    copyFile('pre-commit', '.husky/pre-commit', 'pre-commit hook');
    
    // Install dependencies
    console.log('📦 Installing dependencies...');
    runCommand('npm install --save-dev markdownlint-cli prettier husky lint-staged', 'Installing dependencies');
    
    // Initialize husky
    runCommand('npx husky init', 'Initializing git hooks');
    
    console.log(`
✅ Markdown toolkit setup complete!

📝 Available commands:
  npm run lint:md      - Check markdown files
  npm run lint:md:fix  - Auto-fix markdown issues
  
🔧 To fix all errors now:
  markdown-toolkit fix
`);
    break;
    
  case 'fix':
    const fixScript = path.join(packageDir, 'fix-all-markdown-errors.sh');
    if (fs.existsSync(fixScript)) {
      runCommand(`bash "${fixScript}"`, 'Fixing all markdown errors');
    } else {
      console.error('❌ Fix script not found. Please reinstall the package.');
      process.exit(1);
    }
    break;
    
  case 'help':
  case '--help':
  case '-h':
    showHelp();
    break;
    
  default:
    if (!command) {
      showHelp();
    } else {
      console.error(`❌ Unknown command: ${command}`);
      console.log('');
      showHelp();
      process.exit(1);
    }
}