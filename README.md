# 📦 Portable Markdown Linting Toolkit

A complete, portable solution for adding professional markdown linting to any JavaScript/TypeScript project.

## 🚀 Quick Start

### Option 1: One-Command Setup

```bash
# Copy and run this in your project root:
curl -sSL https://raw.githubusercontent.com/yourusername/markdown-toolkit/main/setup.sh | bash
```

### Option 2: Manual Setup

1. **Copy the `markdown-toolkit` folder to your project**
2. **Run the setup script:**
   ```bash
   ./markdown-toolkit/setup.sh
   ```

### Option 3: Copy Individual Files

Copy these files to your project root:
- `.markdownlint.json` - Linting rules configuration
- `.lintstagedrc.json` - Pre-commit auto-fix configuration
- `scripts/fix-markdown.sh` - Manual fix script

Then install dependencies:
```bash
npm install --save-dev markdownlint-cli lint-staged husky
```

## 📋 What's Included

### Configuration Files

#### `.markdownlint.json`
Professional markdown linting rules:
- Consistent heading styles
- Proper list formatting
- Code block language specifications
- And more...

#### `.lintstagedrc.json`
Auto-fixes on commit:
- Markdown formatting
- Code formatting (if ESLint/Prettier configured)
- JSON formatting

### Scripts

#### `setup.sh`
Complete automated setup:
- Installs required npm packages
- Copies configuration files
- Sets up pre-commit hooks
- Adds npm scripts

#### `fix-markdown.sh`
Comprehensive fix script that handles:
- MD040: Adds language to code blocks
- MD036: Converts emphasis to headings
- MD031: Adds blank lines around code blocks
- MD012: Removes multiple blank lines
- And more...

## 📝 Available Commands After Setup

```bash
# Check all markdown files
npm run lint:md

# Auto-fix markdown issues
npm run lint:md:fix

# Run all linting (code + markdown)
npm run lint:all

# Fix all issues (code + markdown)
npm run fix:all

# Manual comprehensive fix
./scripts/fix-markdown.sh
```

## 🔧 Common Markdown Issues Fixed

### MD040: Code blocks need language

**Before:**
````markdown
```
const code = 'example';
```
````

**After:**
````markdown
```javascript
const code = 'example';
```
````

### MD036: Emphasis instead of heading

**Before:**
```markdown
**Important Section**
```

**After:**
```markdown
### Important Section
```

### MD032: Lists need blank lines

**Before:**
```markdown
Some text
- Item 1
- Item 2
More text
```

**After:**
```markdown
Some text

- Item 1
- Item 2

More text
```

## ⚙️ Customization

### Modify Rules

Edit `.markdownlint.json`:

```json
{
  "MD013": false,        // Line length
  "MD029": false,        // Ordered list numbering
  "MD033": false,        // Allow HTML
  "MD041": false         // First line heading
}
```

### Skip Files

Add to `.markdownlintignore`:
```
node_modules/
dist/
build/
*.min.md
```

## 🎯 Benefits

- ✅ **Consistent Documentation** - Same formatting across all markdown files
- ✅ **Automatic Fixes** - Many issues fixed automatically on commit
- ✅ **CI/CD Ready** - Can be integrated into build pipelines
- ✅ **Zero Config** - Works out of the box with sensible defaults
- ✅ **Portable** - Easy to copy between projects

## 📊 Supported Rules

| Rule | Description | Auto-Fix |
|------|-------------|----------|
| MD001 | Heading increment | ❌ |
| MD003 | Heading style | ✅ |
| MD004 | Unordered list style | ✅ |
| MD007 | List indentation | ✅ |
| MD009 | Trailing spaces | ✅ |
| MD010 | Hard tabs | ✅ |
| MD012 | Multiple blank lines | ✅ |
| MD014 | Dollar before commands | ✅ |
| MD018 | Space after hash | ✅ |
| MD019 | Multiple spaces after hash | ✅ |
| MD022 | Blanks around headings | ✅ |
| MD023 | Heading start indented | ✅ |
| MD025 | Multiple top headings | ❌ |
| MD026 | Trailing punctuation | ✅ |
| MD027 | Multiple spaces blockquote | ✅ |
| MD030 | Spaces after list markers | ✅ |
| MD031 | Blanks around fences | ✅ |
| MD032 | Blanks around lists | ✅ |
| MD034 | Bare URLs | ✅ |
| MD037 | Spaces in emphasis | ✅ |
| MD038 | Spaces in code | ✅ |
| MD039 | Spaces in links | ✅ |
| MD040 | Code block language | ❌ |
| MD041 | First line heading | ❌ |
| MD042 | Empty links | ❌ |
| MD044 | Proper names capitalization | ✅ |
| MD045 | Images alt text | ❌ |
| MD047 | File end newline | ✅ |

## 🚨 Troubleshooting

### Permission Denied
```bash
chmod +x markdown-toolkit/*.sh
chmod +x scripts/*.sh
```

### Husky Not Working
```bash
npx husky init
npm run prepare
```

### Conflicts with Existing Config
- Backup your existing `.markdownlint.json`
- Merge configurations manually
- Test with `npm run lint:md`

## 📚 Resources

- [Markdownlint Rules](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md)
- [CommonMark Spec](https://commonmark.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)

## 📄 License

MIT - Use freely in your projects!

---

Made with ❤️ for better documentation