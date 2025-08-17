#!/usr/bin/env node

// Convenience script that just calls the main CLI with fix command
require('./cli.js');

// Override argv to call fix
process.argv = ['node', 'md-fix', 'fix'];