#!/bin/bash

# ================================================
# Comprehensive Markdown Fix Script
# Fixes common markdown linting issues
# ================================================

echo "🔧 Comprehensive Markdown Fix"
echo "=============================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counter for fixes
FIXED_COUNT=0

# Fix MD040 - Code blocks without language
fix_md040() {
    echo "${BLUE}📝 Fixing MD040 (code blocks without language)...${NC}"
    
    local count=0
    find . -name "*.md" -not -path "./node_modules/*" -not -path "./.next/*" -not -path "./dist/*" -not -path "./build/*" | while read -r file; do
        # Check if file has code blocks without language
        if grep -q "^^\`\`\`$" "$file" 2>/dev/null; then
            # Fix empty code blocks
            perl -i -pe 's/^```$/```text/g if $. > 1' "$file"
            
            # Fix specific patterns
            perl -i -0pe '
                # Directory structures
                s/```\n([\s\S]*?[├└])/```text\n$1/g;
                
                # Shell commands
                s/```\n([$#>])/```bash\n$1/g;
                
                # JSON objects
                s/```\n\{/```json\n{/g;
                s/```\n\[/```json\n[/g;
                
                # JavaScript/TypeScript
                s/```\n(import |export |const |let |var |function |class |interface |type )/```typescript\n$1/g;
                s/```\n(require\(|module\.exports)/```javascript\n$1/g;
                
                # HTML
                s/```\n(<[!a-zA-Z])/```html\n$1/g;
                
                # CSS
                s/```\n([.#a-zA-Z][a-zA-Z0-9-_]*\s*\{)/```css\n$1/g;
                
                # SQL
                s/```\n(SELECT|INSERT|UPDATE|DELETE|CREATE|DROP|ALTER)\s/```sql\n$1/gi;
                
                # YAML
                s/```\n([a-zA-Z_][a-zA-Z0-9_]*:)/```yaml\n$1/g;
                
                # Dockerfile
                s/```\n(FROM |RUN |CMD |EXPOSE |ENV )/```dockerfile\n$1/g;
            ' "$file"
            
            ((count++))
            echo "  Fixed: $file"
        fi
    done
    
    if [ $count -gt 0 ]; then
        echo "${GREEN}  ✅ Fixed $count files${NC}"
        ((FIXED_COUNT+=count))
    else
        echo "${YELLOW}  No MD040 issues found${NC}"
    fi
}

# Fix MD036 - Emphasis used as heading
fix_md036() {
    echo ""
    echo "${BLUE}📝 Fixing MD036 (emphasis as heading)...${NC}"
    
    local count=0
    find . -name "*.md" -not -path "./node_modules/*" -not -path "./.next/*" -not -path "./dist/*" -not -path "./build/*" | while read -r file; do
        # Check for lines that are just bold text
        if grep -q "^\*\*.*\*\*$" "$file" 2>/dev/null; then
            # Convert to heading
            perl -i -pe '
                # Convert standalone bold lines to h3
                s/^\*\*(.*?)\*\*$/### $1/g if !/\*\*.*\*\*.*\*\*/;
                
                # Convert standalone italic to h4
                s/^\*(.*?)\*$/#### $1/g if !/\*.*\*.*\*/;
            ' "$file"
            
            ((count++))
            echo "  Fixed: $file"
        fi
    done
    
    if [ $count -gt 0 ]; then
        echo "${GREEN}  ✅ Fixed $count files${NC}"
        ((FIXED_COUNT+=count))
    else
        echo "${YELLOW}  No MD036 issues found${NC}"
    fi
}

# Fix MD012 - Multiple blank lines
fix_md012() {
    echo ""
    echo "${BLUE}📝 Fixing MD012 (multiple blank lines)...${NC}"
    
    local count=0
    find . -name "*.md" -not -path "./node_modules/*" -not -path "./.next/*" -not -path "./dist/*" -not -path "./build/*" | while read -r file; do
        # Check for multiple blank lines
        if perl -0 -ne 'exit 1 if /\n\n\n/' "$file" 2>/dev/null; then
            :
        else
            # Fix multiple blank lines
            perl -i -0pe 's/\n\n\n+/\n\n/g' "$file"
            ((count++))
            echo "  Fixed: $file"
        fi
    done
    
    if [ $count -gt 0 ]; then
        echo "${GREEN}  ✅ Fixed $count files${NC}"
        ((FIXED_COUNT+=count))
    else
        echo "${YELLOW}  No MD012 issues found${NC}"
    fi
}

# Fix MD031 - Blank lines around fences
fix_md031() {
    echo ""
    echo "${BLUE}📝 Fixing MD031 (blank lines around code blocks)...${NC}"
    
    local count=0
    find . -name "*.md" -not -path "./node_modules/*" -not -path "./.next/*" -not -path "./dist/*" -not -path "./build/*" | while read -r file; do
        # Add blank lines around code blocks
        if grep -q "^\`\`\`" "$file" 2>/dev/null; then
            perl -i -pe '
                # Add blank line before code block if missing
                if (/^```/ && $prev_line ne "" && $prev_line !~ /^```/ && $prev_line !~ /^\s*$/) {
                    $_ = "\n" . $_;
                }
                $prev_line = $_;
            ' "$file"
            
            # Add blank line after code blocks
            perl -i -0pe 's/```\n([^`\n])/```\n\n$1/g' "$file"
            
            ((count++))
            echo "  Fixed: $file"
        fi
    done
    
    if [ $count -gt 0 ]; then
        echo "${GREEN}  ✅ Fixed $count files${NC}"
        ((FIXED_COUNT+=count))
    else
        echo "${YELLOW}  No MD031 issues found${NC}"
    fi
}

# Fix MD047 - File should end with single newline
fix_md047() {
    echo ""
    echo "${BLUE}📝 Fixing MD047 (file ending newline)...${NC}"
    
    local count=0
    find . -name "*.md" -not -path "./node_modules/*" -not -path "./.next/*" -not -path "./dist/*" -not -path "./build/*" | while read -r file; do
        # Ensure file ends with single newline
        if [ -s "$file" ]; then
            # Add newline if missing
            tail -c1 "$file" | read -r _ || echo >> "$file"
            
            # Remove multiple trailing newlines
            perl -i -pe 'chomp if eof' "$file"
            echo >> "$file"
            
            ((count++))
        fi
    done
    
    if [ $count -gt 0 ]; then
        echo "${GREEN}  ✅ Fixed $count files${NC}"
        ((FIXED_COUNT+=count))
    else
        echo "${YELLOW}  No MD047 issues found${NC}"
    fi
}

# Main execution
echo "Starting comprehensive markdown fixes..."
echo ""

# Run all fixes
fix_md040
fix_md036
fix_md012
fix_md031
fix_md047

echo ""
echo "${BLUE}🔧 Running markdownlint auto-fix...${NC}"

# Check if npm script exists
if grep -q '"lint:md:fix"' package.json 2>/dev/null; then
    npm run lint:md:fix 2>&1 | tail -5
else
    echo "${YELLOW}  Note: Add 'lint:md:fix' script to package.json for additional fixes${NC}"
fi

echo ""
echo "${GREEN}═══════════════════════════════════════════${NC}"
echo "${GREEN}✅ Markdown Fix Complete!${NC}"
echo "${GREEN}═══════════════════════════════════════════${NC}"
echo ""

if [ $FIXED_COUNT -gt 0 ]; then
    echo "📊 Fixed issues in ${FIXED_COUNT} file(s)"
else
    echo "📊 No issues found - your markdown is clean!"
fi

echo ""
echo "${YELLOW}💡 Next steps:${NC}"
echo "  1. Review changes with ${BLUE}git diff${NC}"
echo "  2. Run ${BLUE}npm run lint:md${NC} to check for remaining issues"
echo "  3. Commit the fixes"
echo ""