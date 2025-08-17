/**
 * Markdown Toolkit - Complete Linting Solution
 * 
 * A comprehensive toolkit for markdown linting that handles ALL 50 markdownlint errors.
 * Provides automated fixes, pre-commit hooks, and CI/CD integration.
 * 
 * @author Neoneue
 * @license MIT
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

/**
 * Copy configuration files to target directory
 * @param {string} targetDir - Target directory path
 */
function copyConfigs(targetDir = process.cwd()) {
  const configs = [
    '.markdownlint.json',
    '.lintstagedrc.json'
  ];
  
  configs.forEach(config => {
    const src = path.join(__dirname, config);
    const dest = path.join(targetDir, config);
    
    if (fs.existsSync(src)) {
      fs.copyFileSync(src, dest);
      console.log(`✅ Copied ${config}`);
    }
  });
}

/**
 * Set up markdown linting in a project
 * @param {string} projectPath - Path to project directory
 */
function setup(projectPath = process.cwd()) {
  console.log('🚀 Setting up markdown linting...');
  
  // Copy configuration files
  copyConfigs(projectPath);
  
  // Install dependencies
  console.log('📦 Installing dependencies...');
  execSync('npm install --save-dev markdownlint-cli prettier husky lint-staged', {
    cwd: projectPath,
    stdio: 'inherit'
  });
  
  // Initialize husky
  console.log('🔧 Setting up git hooks...');
  execSync('npx husky init', {
    cwd: projectPath,
    stdio: 'inherit'
  });
  
  console.log('✅ Markdown toolkit setup complete!');
}

/**
 * Fix all markdown errors in current directory
 * @param {string} projectPath - Path to project directory
 */
function fixAll(projectPath = process.cwd()) {
  const fixScript = path.join(__dirname, 'fix-all-markdown-errors.sh');
  
  if (fs.existsSync(fixScript)) {
    console.log('🔧 Fixing all markdown errors...');
    execSync(`bash "${fixScript}"`, {
      cwd: projectPath,
      stdio: 'inherit'
    });
    console.log('✅ All markdown errors fixed!');
  } else {
    throw new Error('Fix script not found');
  }
}

/**
 * Run markdown linting
 * @param {string} projectPath - Path to project directory
 * @param {boolean} fix - Whether to auto-fix issues
 */
function lint(projectPath = process.cwd(), fix = false) {
  const command = fix 
    ? "markdownlint '**/*.md' --ignore node_modules --ignore .next --fix"
    : "markdownlint '**/*.md' --ignore node_modules --ignore .next";
    
  execSync(command, {
    cwd: projectPath,
    stdio: 'inherit'
  });
}

module.exports = {
  setup,
  fixAll,
  lint,
  copyConfigs
};