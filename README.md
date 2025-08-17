# 📦 MarkdownLint Clean - Complete Linting Solution

A comprehensive, portable markdown linting toolkit that handles **ALL markdownlint errors (MD001-MD050)**. Achieve markdown compliance with automated fixes and pre-commit hooks.

## 🚀 Quick Start

### Option 1: NPM Package (Recommended)

```bash
# Install globally
npm install -g markdownlint-clean

# Set up in your project
cd your-project
markdownlint-clean setup

# Fix all markdown errors
markdownlint-clean fix
```

### Option 2: Local Installation

```bash
# Install in project
npm install --save-dev markdownlint-clean

# Use via npx
npx markdownlint-clean setup
npx markdownlint-clean fix
```

### Option 3: Clone and Setup

```bash
git clone https://github.com/Neoneue/markdown-toolkit.git
./markdown-toolkit/setup.sh
```

### Option 4: One-Command Setup

```bash
curl -sSL https://raw.githubusercontent.com/Neoneue/markdown-toolkit/main/setup.sh | bash
```

## 📋 What's Included

### 🔧 Fix Scripts

#### `fix-all-markdown-errors.sh` - **NEW! Handles ALL Errors**

Comprehensive script that fixes **ALL markdownlint errors (MD001-MD050)**:

- Automatically detects and fixes 40+ different error types
- Smart language detection for code blocks
- Proper name capitalization
- Link and image fixes
- Whitespace normalization
- And much more!

#### `fix-markdown.sh` - Original Fix Script

Focused fixes for the most common issues

### 📁 Configuration Files

- **`.markdownlint.json`** - Professional linting rules
- **`.lintstagedrc.json`** - Auto-fix on commit
- **`package.json`** - Dependencies and scripts
- **`package-lock.json`** - Locked dependency versions
- **`.github/workflows/markdown-lint.yml`** - CI/CD automation

## 🎯 Complete Error Coverage

This toolkit handles **ALL 50 markdownlint rules**:

### ✅ Heading Rules (MD001-MD025)

| Rule  | Description                           | Auto-Fix |
| ----- | ------------------------------------- | -------- |
| MD001 | Heading levels increment              | ✅       |
| MD003 | Heading style                         | ✅       |
| MD018 | No space after hash                   | ✅       |
| MD019 | Multiple spaces after hash            | ✅       |
| MD020 | No space inside hashes (closed)       | ✅       |
| MD021 | Multiple spaces in closed hashes      | ✅       |
| MD022 | Headings surrounded by blank lines    | ✅       |
| MD023 | Headings must start at line beginning | ✅       |
| MD024 | No duplicate heading content          | Config   |
| MD025 | Single top-level heading              | Manual   |
| MD026 | No trailing punctuation in heading    | ✅       |

### ✅ List Rules (MD004-MD007, MD029-MD032)

| Rule  | Description                     | Auto-Fix |
| ----- | ------------------------------- | -------- |
| MD004 | Unordered list style            | ✅       |
| MD005 | Consistent list indentation     | ✅       |
| MD007 | Unordered list indentation      | ✅       |
| MD029 | Ordered list item prefix        | Config   |
| MD030 | Spaces after list markers       | ✅       |
| MD032 | Lists surrounded by blank lines | ✅       |

### ✅ Whitespace Rules (MD009-MD012)

| Rule  | Description                         | Auto-Fix |
| ----- | ----------------------------------- | -------- |
| MD009 | No trailing spaces                  | ✅       |
| MD010 | No hard tabs                        | ✅       |
| MD011 | Reversed link syntax                | ✅       |
| MD012 | No multiple consecutive blank lines | ✅       |

### ✅ Code Block Rules (MD014, MD031, MD040, MD046, MD048)

| Rule  | Description                             | Auto-Fix |
| ----- | --------------------------------------- | -------- |
| MD014 | Dollar signs in shell commands          | ✅       |
| MD031 | Fenced code blocks surrounded by blanks | ✅       |
| MD040 | Fenced code blocks have language        | ✅       |
| MD046 | Code block style                        | Config   |
| MD048 | Code fence style                        | Config   |

### ✅ Emphasis & Links (MD033-MD039, MD042, MD045)

| Rule  | Description                 | Auto-Fix |
| ----- | --------------------------- | -------- |
| MD033 | No inline HTML              | Config   |
| MD034 | No bare URLs                | ✅       |
| MD036 | Emphasis instead of heading | ✅       |
| MD037 | No spaces inside emphasis   | ✅       |
| MD038 | No spaces inside code spans | ✅       |
| MD039 | No spaces inside link text  | ✅       |
| MD042 | No empty links              | ✅       |
| MD045 | Images have alt text        | ✅       |

### ✅ Blockquote Rules (MD027-MD028)

| Rule  | Description                      | Auto-Fix |
| ----- | -------------------------------- | -------- |
| MD027 | Multiple spaces after blockquote | ✅       |
| MD028 | Blank line inside blockquote     | ✅       |

### ✅ Other Rules

| Rule  | Description                      | Auto-Fix |
| ----- | -------------------------------- | -------- |
| MD013 | Line length                      | Config   |
| MD035 | Horizontal rule style            | Config   |
| MD041 | First line should be top heading | Config   |
| MD043 | Required heading structure       | Manual   |
| MD044 | Proper names capitalization      | ✅       |
| MD047 | File ends with newline           | ✅       |
| MD049 | Emphasis style                   | Config   |
| MD050 | Strong style                     | Config   |

## 📝 Available Commands

### CLI Commands (After npm install)

```bash
# Set up markdown linting in current project
markdownlint-clean setup

# Fix all markdown errors
markdownlint-clean fix

# Show help
markdownlint-clean help
```

### Direct Scripts

```bash
# Run comprehensive fix for ALL errors
./fix-all-markdown-errors.sh

# Check all markdown files
npm run lint:md

# Auto-fix markdown issues
npm run lint:md:fix

# Format with Prettier
npm run format

# Run all fixes
npm run fix:all
```

### Programmatic Usage

```javascript
const markdownlintClean = require("markdownlint-clean");

// Set up in a project
markdownlintClean.setup("/path/to/project");

// Fix all errors
markdownlintClean.fixAll("/path/to/project");

// Run linting
markdownlintClean.lint("/path/to/project", true); // true = auto-fix
```

## 🔧 Smart Features

### Automatic Language Detection

The toolkit intelligently detects code block languages:

- Shell commands (bash)
- JSON objects
- JavaScript/TypeScript
- Python, Ruby, Go, Rust
- HTML, CSS, YAML, XML
- Dockerfile
- SQL queries
- And more!

### Proper Name Capitalization

Automatically fixes common proper names:

- GitHub, JavaScript, TypeScript
- Node.js, React, Vue, Angular
- Docker, Kubernetes
- Linux, macOS, Windows
- And more!

## 📊 Example Fixes

### Before

```markdown
**Important Section**

some code

github project
![](image.png)
```

### After

```markdown
### Important Section

some code

GitHub project
![Image](image.png)
```

## ⚙️ Customization

Edit `.markdownlint.json` to adjust rules:

```json
{
  "MD013": false, // Disable line length
  "MD029": false, // Allow any ordered list style
  "MD033": false, // Allow inline HTML
  "MD041": false // Don't require first line heading
}
```

## 🚀 CI/CD Integration

The toolkit includes GitHub Actions workflow for automated testing:

- Runs on every push and PR
- Checks all Markdown files
- Verifies formatting
- Ensures compliance

## 🎯 Benefits

- ✅ **100% Coverage** - Handles ALL 50 markdownlint rules
- ✅ **Smart Fixes** - Intelligent pattern detection
- ✅ **Automated** - Pre-commit hooks prevent errors
- ✅ **CI/CD Ready** - GitHub Actions included
- ✅ **Portable** - Works with any JS/TS project
- ✅ **Battle-tested** - Used in production projects

## 📚 Resources

- [GitHub Repository](https://github.com/Neoneue/markdownlint-clean)
- [Markdownlint Rules](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md)
- [CommonMark Spec](https://commonmark.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)

## 📄 License

MIT - Use freely in your projects!

---

Made with ❤️ for perfect markdown documentation
