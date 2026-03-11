# Mermaid Rendering Test

This file contains a few Mermaid diagrams of different sizes so you can test:

- inline rendering
- hover preview
- centered previews
- scrolling behavior

---

## 1. Simple Flowchart

```mermaid
flowchart TD
    A[Start] --> B{Is snacks.nvim working?}
    B -->|Yes| C[Great!]
    B -->|No| D[Debug configuration]
    D --> E[Check :checkhealth snacks]
    E --> B
```

Some text after the diagram so you can test leaving the block.

---

## 2. Slightly Larger Diagram

```mermaid
flowchart LR
    User -->|opens markdown| Neovim
    Neovim --> Snacks
    Snacks --> MermaidRenderer
    MermaidRenderer --> ImageMagick
    ImageMagick --> RenderedDiagram
    RenderedDiagram --> Terminal

    Terminal -->|kitty protocol| Display
```

---

## 3. Sequence Diagram

```mermaid
sequenceDiagram
    participant User
    participant Neovim
    participant Snacks
    participant MermaidCLI

    User->>Neovim: Open markdown
    Neovim->>Snacks: Detect mermaid block
    Snacks->>MermaidCLI: Convert diagram
    MermaidCLI-->>Snacks: PNG/SVG
    Snacks-->>Neovim: Render image
```

---

## 4. Large Graph (good for testing centering)

```mermaid
graph TD
    A[Documentation] --> B[Architecture]
    A --> C[Examples]
    A --> D[Tutorials]

    B --> B1[System Design]
    B --> B2[Components]
    B --> B3[Data Flow]

    C --> C1[Simple Example]
    C --> C2[Advanced Example]
    C --> C3[Edge Cases]

    D --> D1[Setup]
    D --> D2[Configuration]
    D --> D3[Troubleshooting]

    D3 --> T1[Check health]
    D3 --> T2[Update plugins]
    D3 --> T3[Verify dependencies]
```

---

## End

Move the cursor inside diagrams to test:

- `Snacks.image.hover()`
- auto-preview
- centered preview window
