# Homebrew Tap for AFM

This is a Homebrew tap for [AFM (Apple Foundation Models API)](https://github.com/scouzi1966/maclocal-api), a macOS server that exposes Apple's Foundation Models through OpenAI-compatible API endpoints.

## Installation

```bash
# Add the tap
brew tap scouzi1966/afm

# Install AFM
brew install afm

# Verify installation
afm --version
```

## Requirements

- **macOS 26+** with Apple Intelligence enabled
- **Apple Silicon Mac** (M1/M2/M3/M4 series)
- Apple Intelligence enabled in System Settings → Apple Intelligence & Siri

## Usage

```bash
# Start server (default port 9999)
afm

# Start with custom port and verbose logging
afm --port 8080 --verbose

# Single prompt mode
afm -i "you are a pirate, speeak in pirate jargon" -s "Explain quantum computing"
afm -i "you are a stubborn french speaking assistant. You only reply in french. Translate to french when necessary" -s "Write a story about Einstein"

# Pipe input support
echo "What is the meaning of life?" | afm
git log --oneline | head -5 | afm -i "summarize"

# Custom instructions
echo "Review this code" | afm -i "You are a senior software engineer"
```

## Features

- 🔗 **OpenAI API Compatible** - Works with existing OpenAI client libraries
- 📱 **Apple Foundation Models** - Uses Apple's on-device language models  
- 🔒 **Privacy-First** - All processing happens locally on your device
- ⚡ **Fast & Lightweight** - No network calls, no API keys required
- 🛠️ **Easy Integration** - Drop-in replacement for OpenAI API endpoints
- 📊 **Token Usage Tracking** - Provides accurate token consumption metrics
- 🚰 **CLI Composability** - Accepts piped input from other commands

## Documentation

For complete documentation, visit: https://github.com/scouzi1966/maclocal-api

## License

MIT License - see the main repository for details.
