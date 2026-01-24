# Homebrew Tap for AFM & Vesta

This Homebrew tap provides:
- **[AFM](https://github.com/scouzi1966/maclocal-api)** - Apple Foundation Models API server with OpenAI-compatible endpoints
- **[Vesta](https://github.com/scouzi1966/vesta-mac-dist)** - macOS AI chat app with Apple Intelligence, MLX, and llama.cpp backends

## Installation

```bash
# Add the tap
brew tap scouzi1966/afm

# Install AFM (CLI server)
brew install afm

# Install Vesta (macOS app)
brew install --cask vesta
```

---

## AFM - Apple Foundation Models API

### Latest: v0.5.6 - Security Enhancement: Localhost-Only Binding

- **Localhost-Only Binding**: Server now binds exclusively to localhost (127.0.0.1) for enhanced security
- **Network Isolation**: Prevents external network access to the AFM server
- **Zero Configuration**: No additional setup required - security enabled by default

### Requirements

- **macOS 26+** with Apple Intelligence enabled
- **Apple Silicon Mac** (M1/M2/M3/M4 series)
- Apple Intelligence enabled in System Settings → Apple Intelligence & Siri

### Usage

```bash
# Start server (default port 9999)
afm

# Start with custom port and verbose logging
afm --port 8080 --verbose

# Single prompt mode
afm -i "you are a pirate, speak in pirate jargon" -s "Explain quantum computing"

# Pipe input support
echo "What is the meaning of life?" | afm
git log --oneline | head -5 | afm -i "summarize"
```

### Features

- OpenAI API Compatible - Works with existing OpenAI client libraries
- Apple Foundation Models - Uses Apple's on-device language models
- Privacy-First - All processing happens locally on your device
- Fast & Lightweight - No network calls, no API keys required
- CLI Composability - Accepts piped input from other commands

---

## Vesta - macOS AI Chat App

### Latest: v0.9.0

- **Vision capabilities** with Qwen3-VL model (describe images, analyze screenshots)
- **Continuity Camera** input (capture photos directly from iPhone/iPad)
- **Code syntax highlighting** for 20+ programming languages
- **LaTeX math rendering** with KaTeX
- **GitHub Flavored Markdown** rendering

### Requirements

- **macOS 26+** (Tahoe)
- **Apple Silicon Mac** (M1/M2/M3/M4 series)

### Features

- Apple Intelligence integration for on-device AI
- Vision mode for image understanding (llama.cpp + Qwen3-VL)
- MLX backend for Apple Silicon optimized inference
- llama.cpp backend for GGUF model support
- Voice input with speech-to-text
- Developer ID signed and Apple notarized

---

## Documentation

- AFM: https://github.com/scouzi1966/maclocal-api
- Vesta: https://github.com/scouzi1966/vesta-mac-dist

## License

MIT License - see the respective repositories for details.
