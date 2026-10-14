# CraftPDF

<p align="center">
  <b>The PDF Workbench — Rebuilt from the ground up in pure Rust.</b><br>
  Read, edit, organize, combine, split, sign, annotate, and secure PDFs in a blazing fast, private, native desktop application.<br>
  <b>Windows · macOS · Linux · Web</b>
</p>

<p align="center">
  <img alt="License: MIT OR Apache-2.0" src="https://img.shields.io/badge/license-MIT%20OR%20Apache--2.0-12a58a">
  <img alt="Written in Rust" src="https://img.shields.io/badge/written%20in-Rust-0a7563">
  <img alt="Platforms: Windows · macOS · Linux · Web" src="https://img.shields.io/badge/runs%20on-Windows%20%C2%B7%20macOS%20%C2%B7%20Linux%20%C2%B7%20Web-12a58a">
  <img alt="100% Offline & Private" src="https://img.shields.io/badge/offline-no%20telemetry-0a7563">
</p>

<p align="center">
  <b>Maintained by Sarthak (<a href="https://github.com/SarthAyush">@SarthAyush</a>)</b>
</p>

---

## ⚡ Highlights

<table>
<tr>
<td width="33%" valign="top">

### 🎨 Faithful Rendering
Complete typographics: world scripts, vertical text, color emoji, gradients, soft masks, layers, blend modes, and transparency. Powered by `wgpu` with OpenGL fallback.

</td>
<td width="33%" valign="top">

### 🛡️ Fearless & Safe
Atomic saves leave original files intact until writes are verified. Deep undo/redo stacks, crash recovery, and incremental revision tracking protect your work.

</td>
<td width="33%" valign="top">

### 🔒 100% Offline & Private
No accounts, no telemetry, no cloud lock-in. All processing, OCR, conversions, signing, and indexing happen entirely on your local machine.

</td>
</tr>
</table>

---

## ✨ Features

- **📖 Complete PDF Viewer:** Single-page, two-page, continuous scroll, book layout, presentation mode, full-text search with regex, bookmarks, and document outline.
- **✂️ Organize & Rearrange:** Visual thumbnail grid with drag-and-drop page reordering, rotation, page extraction, splitting, and merging.
- **📝 Annotations & Comments:** Sticky notes, text highlights, underlines, strikethroughs, freehand drawing with pressure sensitivity, stamps, and threaded comments.
- **✍️ Forms & Signatures:** Interactive AcroForms filling and calculation, XFA support, digital PKI certificate signing, self-signed signatures, and ink signatures.
- **🔍 OCR (Optical Character Recognition):** Offline embedded text recognition to make scanned PDFs and images instantly searchable and selectable.
- **🛡️ Redaction & Sanitization:** True structural redaction removing text, hidden metadata, attachments, and embedded streams irreversibly.
- **📐 Measurement Tools:** Precise distance, perimeter, area, and scale calibration for architectural and engineering drawings.
- **🖥️ Custom Workspace Docking:** Flexible dockable UI tabs, floating windows, split panels, dark/light theme switching, and keyboard shortcut customization.

---

## 🚀 Getting Started

### Prerequisites

- [Rust](https://rustup.rs/) (Rust 1.95+ or stable Edition 2024 compiler)
- C/C++ build tools:
  - **Windows:** Visual Studio C++ Build Tools (MSVC)
  - **Linux:** `build-essential libx11-dev libasound2-dev libfontconfig1-dev`
  - **macOS:** Xcode Command Line Tools

### Quick Build & Run

Clone the repository:
```bash
git clone https://github.com/SarthAyush/CraftPDF.git
cd CraftPDF/pdfcraft
```

Run the desktop application:
```bash
cargo run --release -p pdfcraft
```

Or run the CLI automation tool:
```bash
cargo run --release -p pdfcraft-cli -- --help
```

---

## 📂 Architecture

CraftPDF is built as a clean, highly modular Rust workspace:

| Crate | Responsibility |
| :--- | :--- |
| **`apps/pdfcraft`** | Native desktop shell (`eframe` / `wgpu`) for Windows, macOS, and Linux |
| **`apps/pdfcraft-cli`** | Headless CLI tool for batch conversions, merges, metadata audits, and automation |
| **`apps/pdfcraft-web`** | WebAssembly (WASM) browser distribution |
| **`crates/ui-egui`** | Complete graphical user interface, tools catalog, inspector panels, and theme engine |
| **`crates/engine`** | Document model, command dispatch, undo history, and transaction lifecycle |
| **`crates/render`** | Vector and raster PDF page rendering engine |
| **`crates/cos`** | Core PDF low-level syntax parser, object stream decoder, and serializer |
| **`crates/crypt`** | PDF encryption, standard security handlers, and AES-256 decryption |
| **`crates/sign`** | PKI digital signatures, certificate validation, and cryptographic timestamps |
| **`crates/ocr`** | Embedded machine learning OCR inference engine |
| **`crates/redact`** | Irreversible deep structural content redaction |

---

## 📜 License

This project is dual-licensed under:
- **MIT License** ([LICENSE-MIT](LICENSE-MIT))
- **Apache License, Version 2.0** ([LICENSE-APACHE](LICENSE-APACHE))

Original work and core library foundations derived from the open-source community. See [ATTRIBUTION.md](ATTRIBUTION.md) and [NOTICE](NOTICE) for complete third-party component licenses.
