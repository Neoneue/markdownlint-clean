#!/usr/bin/env node

// Convenience script that just calls the main CLI with setup command
require('./cli.js');

// Override argv to call setup
process.argv = ['node', 'md-setup', 'setup'];