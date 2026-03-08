#!/bin/bash

# Claude Code Auto Workflow Plugin - Setup Script
# Initialize project structure with framework-specific rules

set -e

echo "🚀 Setting up Claude Code Auto Workflow Plugin..."
echo ""

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p specs/issues
mkdir -p specs/designs
mkdir -p specs/comments
mkdir -p specs/rules

# Add .gitkeep to preserve empty directories
touch specs/issues/.gitkeep
touch specs/designs/.gitkeep
touch specs/comments/.gitkeep

echo "✅ Directories created"
echo ""

# Detect framework
echo "🔍 Detecting framework..."
FRAMEWORK=""
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check for Rails
if [ -f "Gemfile" ] || [ -f "config/environment.rb" ]; then
  FRAMEWORK="rails"
  echo "✅ Rails detected (Gemfile found)"

# Check for Flutter
elif [ -f "pubspec.yaml" ] || [ -f "lib/main.dart" ]; then
  FRAMEWORK="flutter"
  echo "✅ Flutter detected (pubspec.yaml found)"

# Check for React/Next.js
elif [ -f "package.json" ]; then
  if grep -q '"react"' package.json 2>/dev/null || grep -q '"next"' package.json 2>/dev/null; then
    FRAMEWORK="react"
    echo "✅ React detected (package.json found)"
  fi

# Check for Django
elif [ -f "manage.py" ] || [ -f "requirements.txt" ]; then
  FRAMEWORK="django"
  echo "✅ Django detected (manage.py or requirements.txt found)"
fi

echo ""

# Copy framework-specific rules or ask user
if [ -n "$FRAMEWORK" ] && [ -f "$PLUGIN_DIR/templates/$FRAMEWORK.md" ]; then
  echo "📋 Copying $FRAMEWORK rules..."
  cp "$PLUGIN_DIR/templates/$FRAMEWORK.md" "specs/rules/$FRAMEWORK.md"
  echo "✅ specs/rules/$FRAMEWORK.md created"
else
  echo "❓ No framework detected. Which template would you like to use?"
  echo ""
  echo "Available templates:"

  # List available templates
  TEMPLATES=()
  if [ -f "$PLUGIN_DIR/templates/rails.md" ]; then
    TEMPLATES+=("rails")
    echo "  1) Rails"
  fi
  if [ -f "$PLUGIN_DIR/templates/flutter.md" ]; then
    TEMPLATES+=("flutter")
    echo "  2) Flutter"
  fi
  echo "  0) Skip (add later manually)"
  echo ""

  read -p "Enter choice (0-${#TEMPLATES[@]}): " choice

  if [ "$choice" -gt 0 ] && [ "$choice" -le "${#TEMPLATES[@]}" ]; then
    selected_framework="${TEMPLATES[$((choice - 1))]}"
    echo ""
    echo "📋 Copying $selected_framework rules..."
    cp "$PLUGIN_DIR/templates/$selected_framework.md" "specs/rules/$selected_framework.md"
    echo "✅ specs/rules/$selected_framework.md created"
  else
    echo "⏭️  Skipped. Add framework rules later:"
    echo "   cp templates/rails.md specs/rules/rails.md"
    echo "   cp templates/flutter.md specs/rules/flutter.md"
  fi
fi

echo ""

# Create prd.md if it doesn't exist
if [ ! -f specs/prd.md ]; then
  echo "📝 Creating specs/prd.md template..."
  cat > specs/prd.md << 'EOF'
# Product Requirements Document

## Project Overview
Brief description of the project and its goals.

## Features
- Feature 1
- Feature 2
- Feature 3

## User Stories
- As a [user type], I want [functionality] so that [benefit]

## Technical Requirements
- Requirement 1
- Requirement 2

## Success Criteria
- Criterion 1
- Criterion 2
EOF
  echo "✅ specs/prd.md created"
else
  echo "⏭️  specs/prd.md already exists, skipping"
fi

echo ""

# Create story.md if it doesn't exist
if [ ! -f specs/story.md ]; then
  echo "📝 Creating specs/story.md template..."
  cat > specs/story.md << 'EOF'
# Story Breakdown

## Phase 1: Foundation
- [ ] 1. Project Setup - Initialize Repository
- [ ] 2. Configure Build Environment
- [ ] 3. Setup CI/CD Pipeline

## Phase 2: Core Features
- [ ] 4. Feature One - Main Implementation
- [ ] 5. Feature Two - Main Implementation
- [ ] 6. Feature Three - Main Implementation

## Phase 3: Polish
- [ ] 7. Testing & Quality Assurance
- [ ] 8. Documentation & Deployment

---

**Format Rules:**
- Use `- [ ]` for task status
- Format: `[number]. [title]`
- Keep titles clear and descriptive
EOF
  echo "✅ specs/story.md created"
else
  echo "⏭️  specs/story.md already exists, skipping"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "📚 Next steps:"
echo "   1. Edit specs/prd.md with your project requirements"
echo "   2. Edit specs/story.md with your task breakdown"
echo "   3. Run: /generate-issues all"
echo "   4. Review issues in specs/issues/ and approve them"
echo "   5. Run: /sync-github-issues"
echo "   6. Run: /implement-issue [number]"
echo ""
echo "📖 For more details, see: README.md"
