# Prism 1.30.0 — locally served Swift highlighting

Upstream: https://github.com/PrismJS/prism/tree/v1.30.0
Documentation: https://prismjs.com/download.html
License: MIT, included in LICENSE. Downloaded 21 September 2026.

Unmodified upstream core and Swift grammar. No CDN or server-side highlighter dependency.
`highlight-swift.js` is the local initializer. Core uses data-manual; all three scripts defer in order so highlighting starts only after the Swift grammar is available. Plain escaped code remains readable if any script fails.

SHA-256:
- `prism-core.min.js`: `6caad316dd991f24f8004e0b9c19c055cb5829ff65e973fbee406f96d81b8e7e`
- `prism-swift.min.js`: `69c8a062618949fbc7b69989ab7fb2b7bc111b28ea329e53713c7a2885614b20`
- `LICENSE`: `2b947f0901a7ffcf08a89957da9783c0e9c6e72cb6ce8e959f501ab5409e4d2b`
