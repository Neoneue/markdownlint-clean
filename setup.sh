#!/bin/bash

# ================================================
# Markdown Linting Setup Script
# Portable solution for any JS/TS project
# ================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo "${BLUE}║   📝 Markdown Linting Setup Installer      ║${NC}"
echo "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Check if in a npm project
if [ ! -f "package.json" ]; then
    echo "${RED}❌ Error: package.json not found!${NC}"
    echo "${YELLOW}Please run this from your project root.${NC}"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "${BLUE}📦 Installing required npm packages...${NC}"
npm install --save-dev markdownlint-cli lint-staged husky

echo ""
echo "${BLUE}📁 Copying configuration files...${NC}"

# Copy markdownlint config
if [ -f "$SCRIPT_DIR/.markdownlint.json" ]; then
    cp "$SCRIPT_DIR/.markdownlint.json" .
    echo "${GREEN}  ✅ .markdownlint.json${NC}"
else
    cat > .markdownlint.json << 'EOF'
{
  "default": true,
  "MD003": { "style": "atx" },
  "MD004": { "style": "dash" },
  "MD007": { "indent": 2 },
  "MD013": false,
  "MD024": { "siblings_only": true },
  "MD029": false,
  "MD033": false,
  "MD035": { "style": "---" },
  "MD041": false,
  "MD046": { "style": "fenced" },
  "MD048": { "style": "backtick" },
  "MD049": { "style": "asterisk" },
  "MD050": { "style": "asterisk" }
}
EOF
    echo "${GREEN}  ✅ .markdownlint.json (created)${NC}"
fi

# Copy lint-staged config
if [ -f "$SCRIPT_DIR/.lintstagedrc.json" ]; then
    cp "$SCRIPT_DIR/.lintstagedrc.json" .
    echo "${GREEN}  ✅ .lintstagedrc.json${NC}"
else
    cat > .lintstagedrc.json << 'EOF'
{
  "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
  "*.{json,css,scss,html}": ["prettier --write"],
  "*.md": ["markdownlint --fix", "prettier --write"],
  "package.json": ["prettier --write"]
}
EOF
    echo "${GREEN}  ✅ .lintstagedrc.json (created)${NC}"
fi

# Create scripts directory
mkdir -p scripts

# Copy fix script
if [ -f "$SCRIPT_DIR/fix-markdown.sh" ]; then
    cp "$SCRIPT_DIR/fix-markdown.sh" scripts/
    chmod +x scripts/fix-markdown.sh
    echo "${GREEN}  ✅ scripts/fix-markdown.sh${NC}"
else
    cat > scripts/fix-markdown.sh << 'EOF'
#!/bin/bash

echo "🔧 Fixing Markdown Issues..."
echo "============================"

# Fix MD040 - Add language to code blocks
echo "📝 Adding language identifiers to code blocks..."
find . -name "*.md" -not -path "./node_modules/*" | while read -r file; do
    perl -i -pe 's/^```$/```text/g if $. > 1' "$file"
    perl -i -0pe '
        s/```\n([\s\S]*?├──|[\s\S]*?└──)/```text\n$1/g;
        s/```\n(\$|>|#)/```bash\n$1/g;
        s/```\n\{/```json\n{/g;
        s/```\n(import |export |const |let |var |function |class )/```typescript\n$1/g;
    ' "$file"
done

# Fix MD036 - Convert emphasis to headings
echo "📝 Converting emphasis to proper headings..."
find . -name "*.md" -not -path "./node_modules/*" | while read -r file; do
    perl -i -pe 's/^\*\*(.*?)\*\*$/### $1/g' "$file"
done

# Fix MD012 - Multiple blank lines
echo "📝 Removing multiple blank lines..."
find . -name "*.md" -not -path "./node_modules/*" | while read -r file; do
    perl -i -0pe 's/\n\n\n+/\n\n/g' "$file"
done

# Run markdownlint auto-fix
echo "🔧 Running markdownlint auto-fix..."
npm run lint:md:fix

echo ""
echo "✅ Markdown fixes complete!"
echo "Run 'npm run lint:md' to check for remaining issues."
EOF
    chmod +x scripts/fix-markdown.sh
    echo "${GREEN}  ✅ scripts/fix-markdown.sh (created)${NC}"
fi

echo ""
echo "${BLUE}📝 Adding npm scripts...${NC}"

# Add npm scripts
node << 'EOF'
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

if (!pkg.scripts) pkg.scripts = {};

// Add markdown scripts
pkg.scripts['lint:md'] = "markdownlint '**/*.md' --ignore node_modules --ignore .next --ignore dist --ignore build";
pkg.scripts['lint:md:fix'] = "markdownlint '**/*.md' --ignore node_modules --ignore .next --ignore dist --ignore build --fix";

// Add combined scripts if not present
if (!pkg.scripts['lint:all']) {
    if (pkg.scripts['lint']) {
        pkg.scripts['lint:all'] = "npm run lint && npm run lint:md";
    } else {
        pkg.scripts['lint:all'] = "npm run lint:md";
    }
}

if (!pkg.scripts['fix:all']) {
    if (pkg.scripts['lint:fix']) {
        pkg.scripts['fix:all'] = "npm run lint:fix && npm run lint:md:fix";
    } else {
        pkg.scripts['fix:all'] = "npm run lint:md:fix";
    }
}

// Add Husky prepare
pkg.scripts['prepare'] = 'husky';

fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
console.log('  ✅ Updated package.json');
EOF

echo ""
echo "${BLUE}🐺 Setting up Husky pre-commit hooks...${NC}"

# Initialize Husky
npx husky init 2>/dev/null || true

# Create pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/bin/sh

echo "🚀 Running pre-commit checks..."

# Run lint-staged
npx lint-staged

if [ $? -ne 0 ]; then
  echo "❌ Pre-commit checks failed!"
  exit 1
fi

echo "✅ Pre-commit checks passed!"
EOF

chmod +x .husky/pre-commit
echo "${GREEN}  ✅ .husky/pre-commit${NC}"

# Create .markdownlintignore
cat > .markdownlintignore << 'EOF'
node_modules/
.next/
dist/
build/
coverage/
*.min.md
EOF
echo "${GREEN}  ✅ .markdownlintignore${NC}"

echo ""
echo "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo "${GREEN}║    ✅ Setup Complete!                      ║${NC}"
echo "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""
echo "${YELLOW}📋 Available Commands:${NC}"
echo ""
echo "  ${BLUE}npm run lint:md${NC}      - Check markdown files"
echo "  ${BLUE}npm run lint:md:fix${NC}  - Auto-fix markdown issues"
echo "  ${BLUE}npm run lint:all${NC}     - Run all linting"
echo "  ${BLUE}npm run fix:all${NC}      - Fix all issues"
echo ""
echo "  ${BLUE}./scripts/fix-markdown.sh${NC}"
echo "                       - Manual comprehensive fix"
echo ""
echo "${YELLOW}📚 Next Steps:${NC}"
echo "  1. Run ${BLUE}npm run lint:md${NC} to check current files"
echo "  2. Run ${BLUE}npm run lint:md:fix${NC} to auto-fix issues"
echo "  3. Commit changes to activate pre-commit hooks"
echo ""
echo "${GREEN}Happy documenting! 📝${NC}"